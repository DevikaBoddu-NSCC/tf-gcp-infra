provider "google" {
  project = var.project
  region  = var.region
}

provider "google-beta" {
  project = var.project
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                            = var.vpc_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.route_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

resource "google_compute_subnetwork" "webapp_subnet" {
  name          = var.webapp_subnet
  ip_cidr_range = var.webapp_ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = var.db_subnet
  ip_cidr_range = var.db_ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}
resource "google_compute_route" "webapp_route_name" {
  name             = var.webapp_route_name
  dest_range       = var.dest_range
  network          = google_compute_network.vpc_network.id
  next_hop_gateway = var.next_hop_gateway

}

data "google_compute_image" "latest_custom_image" {
  family = var.image_family
}

output "latest_custom_image_name" {
  value = data.google_compute_image.latest_custom_image.name
}

resource "google_compute_firewall" "allow_http" {
  name    = var.allow_http
  network = google_compute_network.vpc_network.id

  allow {
    protocol = var.protocol
    ports    = var.port_allow
  }

  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}
resource "google_compute_firewall" "allow_ssh_from_my_ip" {
  name    = var.allow_ssh_from_my_ip
  network = google_compute_network.vpc_network.id

  allow {
    protocol = var.protocol
    ports    = var.port_deny
  }

  source_ranges = var.my_ip_address
}
#assignment4

resource "google_compute_global_address" "private_ip_address" {
  name          = var.private_ip_address
  purpose       = var.purpose
  address_type  = var.address_type
  prefix_length = var.prefix_length
  network       = google_compute_network.vpc_network.id
}
resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.vpc_network.id
  service                 = var.service
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
  deletion_policy         = var.deletion_policy
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "cloud_sql_instance" {
  name               = "sql-instance-${random_id.db_name_suffix.hex}"
  region             = var.region
  database_version   = var.database_version
  deletion_protection = var.deletion_protection
  settings {
    tier = var.tier_sql
    disk_type = var.disk_type_sql
    disk_size = var.disk_size_sql
    availability_type  = var.availability_type_sql
    
    ip_configuration {
      ipv4_enabled         = var.ipv4_enabled
      private_network      = google_compute_network.vpc_network.id
    }
    backup_configuration {
      enabled = true
      binary_log_enabled = true
    }
  }
  
  depends_on = [google_service_networking_connection.default]
}

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.cloud_sql_instance.id
}
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
resource "google_sql_user" "db_user" {
  name     = var.db_user_name
  instance = google_sql_database_instance.cloud_sql_instance.id
  password = random_password.password.result
}

resource "google_compute_instance" "webapp_vm_instance" {
  name         = var.webapp_vm_instance
  machine_type = var.machine_type
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = data.google_compute_image.latest_custom_image.self_link
      size  = var.size
      type  = var.type
    }
  }
  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.webapp_subnet.id
    access_config {}
  }
  tags = var.tags
  service_account {
    email  = var.service_account_email
    scopes = var.scopes
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
    startup-script = <<-EOT
        # #!/bin/bash
        # ENV_FILE="/opt/csye6225/webapp/.env"
        # if [ ! -f "$ENV_FILE" ]; then
        #   sed -i 's/^DB_HOST=.*/DB_HOST=${google_sql_database_instance.cloud_sql_instance.ip_address.0.ip_address}/' "$ENV_FILE"
        #   sed -i 's/^DB_USERNAME=.*/DB_USERNAME=${google_sql_user.db_user.name}/' "$ENV_FILE"
        #   sed -i 's/^DB_PASSWORD=.*/DB_PASSWORD=${google_sql_user.db_user.password}/' "$ENV_FILE"
        #   sed -i 's/^DB_NAME=.*/DB_NAME=${google_sql_database.database.name}/' "$ENV_FILE"
        # fi
        #!/bin/bash

        ENV_FILE="/opt/csye6225/webapp/.env"
        if [ ! -f "$ENV_FILE" ]; then
            touch "$ENV_FILE"
        fi
        echo "DB_DIALECT=mysql" >> "$ENV_FILE"
        echo "DB_HOST=${google_sql_database_instance.cloud_sql_instance.ip_address.0.ip_address}" >> "$ENV_FILE"
        echo "DB_USERNAME=${google_sql_user.db_user.name}" >> "$ENV_FILE"
        echo "DB_PASSWORD=${google_sql_user.db_user.password}" >> "$ENV_FILE"
        echo "DB_NAME=${google_sql_database.database.name}" >> "$ENV_FILE"
        echo "PORT = 3000" >> "$ENV_FILE"
      EOT
  }

  depends_on = [google_service_networking_connection.default]
}
 
