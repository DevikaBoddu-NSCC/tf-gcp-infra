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
//assignment4
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
//assignment5

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
  host     = "%"
  instance = google_sql_database_instance.cloud_sql_instance.id
  password = random_password.password.result
}


resource "google_compute_firewall" "allow_sql_access" {
  name    = var.allow_sql_access
  network = google_compute_network.vpc_network.id

  allow {
    protocol = var.protocol
    ports    = var.db_port
  }

  source_ranges = var.webapp_subnet_range
  destination_ranges = ["${google_compute_global_address.private_ip_address.address}/16"]
  target_tags = var.tags
}
#assignment6

data "google_iam_policy" "admin" {
  binding {
    role = var.role_serviceAccountUser

    members = [
      "user:${google_service_account.service_account.email}",
    ]
  }
}

resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = var.display_name
}

resource "google_project_iam_binding" "logging_admin_binding" {
  project = var.project
  role    = var.role_loggingadmin

  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}

resource "google_project_iam_binding" "monitoring_metric_writer_binding" {
  project = var.project
  role    = var.role_monitoringmetricWriter

  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}

resource "google_project_iam_binding" "pub_sub_publisher" {
  project = var.project
  role    = var.role_pubsubpublisher

  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}

//assignment 7
resource "google_pubsub_topic" "cloud_trigger_topic" {
  name = var.cloud_trigger_topic_name
}

resource "google_storage_bucket" "bucket" {
  name                        = "${var.project}-gcf-source" 
  location                     = var.location
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "object" {
  name   = var.object_name
  bucket = google_storage_bucket.bucket.name
  source = var.object_source_path
}
resource "google_cloudfunctions2_function" "function" {
  name        = var.function_name
  location    = var.region
  description = var.function_description
  depends_on  = [google_vpc_access_connector.connector]

  build_config {
    runtime     = var.function_runtime
    entry_point = var.function_entry_point
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.object.name
      }
    }
  }

  service_config {
    max_instance_count               = var.function_max_instance_count
    min_instance_count               = var.function_min_instance_count
    available_memory                 = var.function_available_memory
    timeout_seconds                  = var.function_timeout_seconds
    max_instance_request_concurrency = var.function_max_instance_request_concurrency
    available_cpu                    = var.function_available_cpu
    environment_variables = {
      DB_USERNAME   = var.db_user_name
      DB_PASSWORD   = google_sql_user.db_user.password
      API_KEY       = var.function_api_key
      DB_IP_Address = google_sql_database_instance.cloud_sql_instance.ip_address.0.ip_address
    }
    vpc_connector                  = google_vpc_access_connector.connector.name
    vpc_connector_egress_settings  = var.function_vpc_connector_egress_settings
    ingress_settings               = var.function_ingress_settings
    all_traffic_on_latest_revision = var.function_all_traffic_on_latest_revision
    service_account_email          = google_service_account.service_account.email
  }

  event_trigger {
    trigger_region = var.region
    event_type     = var.function_event_type
    pubsub_topic   = google_pubsub_topic.cloud_trigger_topic.id
    retry_policy   = var.function_retry_policy
  }
}

resource "google_vpc_access_connector" "connector" {
  name          = var.connector_name
  ip_cidr_range = var.connector_ip_cidr_range
  network       = google_compute_network.vpc_network.name
  region        = var.region
}
#assignment8
resource "google_compute_region_instance_template" "instance_template" {
  name_prefix  = "csye6225-instance-template-"
  description = "instance template"
  machine_type = var.machine_type

  // boot disk
  disk {
      source_image = data.google_compute_image.latest_custom_image.self_link
      type  = var.type
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.webapp_subnet.id
    access_config {}
  }

  service_account {
    email  = google_service_account.service_account.email
    scopes = var.scopes
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
    startup-script = <<-EOT
        #!/bin/bash
        ENV_FILE="/opt/csye6225/webapp/.env"
        if [ -e "$ENV_FILE" ]; then
            sed -i '1iLOGPATH=/var/log/webapp/' "$ENV_FILE"
            sed -i 's/^DB_HOST=.*/DB_HOST=${google_sql_database_instance.cloud_sql_instance.ip_address.0.ip_address}/' "$ENV_FILE"
            sed -i 's/^DB_USERNAME=.*/DB_USERNAME=${google_sql_user.db_user.name}/' "$ENV_FILE"
            sed -i 's/^DB_PASSWORD=.*/DB_PASSWORD=${google_sql_user.db_user.password}/' "$ENV_FILE"
            sed -i 's/^DB_NAME=.*/DB_NAME=${google_sql_database.database.name}/' "$ENV_FILE"
            echo "$ENV_FILE"
        fi
        sudo chown -R csye6225:csye6225 /opt/csye6225/
        sudo chown -R csye6225:csye6225 /var/log/webapp/
        sudo systemctl restart webapp
      EOT
  }

  //depends_on = [google_service_networking_connection.default, google_service_account.service_account]

  lifecycle {
    create_before_destroy = true
  }
  tags = ["load-balanced-backend"]
}
resource "google_compute_region_instance_group_manager" "instance_group_manager" {
  name               = "csye6225-instance-group-manager-1"
  named_port {
    name = "http"
    port = 3000
  }
  version {
    instance_template = google_compute_region_instance_template.instance_template.self_link
  }
  base_instance_name = "instance-group-manager-1"
  auto_healing_policies {
    health_check      = google_compute_health_check.https.id
    initial_delay_sec = 300
  }
  # target_size        = 2
}
resource "google_compute_health_check" "https" {
  name               = "webapp-health-check"
  check_interval_sec = 5
  healthy_threshold  = 2
  timeout_sec         = 5
  unhealthy_threshold = 2
  https_health_check {
    port = 443
    port_specification = "USE_FIXED_PORT"
    proxy_header       = "NONE"
    request_path       = "/healthz"
  }
  
}

resource "google_compute_region_autoscaler" "autoscaler" {
  name   = "csye6225-region-autoscaler-1"
  region = var.region
  target = google_compute_region_instance_group_manager.instance_group_manager.id

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 180
    mode            = "ON"
    cpu_utilization {
      target = 0.05
    }
  }
}

# resource "google_compute_managed_ssl_certificate" "ssl" {
#   provider = google-beta
#   name     = "ssl-1"
#   managed {
#     domains = ["devikaboddu-csye6225.me"]
#   }
# }

//load-balancer
resource "google_compute_global_address" "default" {
  name         = "address-name"
  address_type = "EXTERNAL"
 
}
resource "google_compute_subnetwork" "proxy_only" {
  name          = "proxy-only-subnet"
  ip_cidr_range = "10.129.0.0/23"
  network       = google_compute_network.vpc_network.id
  purpose       = "REGIONAL_MANAGED_PROXY"
  region        = var.region
  role          = "ACTIVE"
}
resource "google_compute_firewall" "default" {
  name = "fw-allow-health-check"
  allow {
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["load-balanced-backend"]
}
resource "google_compute_firewall" "allow_proxy" {
  name = "fw-allow-proxies"
  # allow {
  #   ports    = ["443"]
  #   protocol = "tcp"
  # }
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  allow {
    ports    = ["3000"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["10.129.0.0/23"]
  target_tags   = ["load-balanced-backend"]
}

resource "google_compute_backend_service" "default" {
  name                  = "webapp-backend-service-1"
  # region                = var.region
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_health_check.https.id]
  protocol              = "HTTP"
  session_affinity      = "NONE"
  timeout_sec           = 30
  backend {
    group           = google_compute_region_instance_group_manager.instance_group_manager.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}
resource "google_compute_url_map" "default" {
  name            = "lb-url-map-1"
  # region = var.region
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_https_proxy" "default" {
  provider = google-beta
  name     = "myservice-https-proxy-1"
  url_map  = google_compute_url_map.default.id
  ssl_certificates = [
    google_compute_managed_ssl_certificate.ssl.id
  ]
  depends_on = [
    google_compute_managed_ssl_certificate.ssl
  ]
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "lb-forwarding-rule-1"
  provider   = google-beta
  depends_on = [google_compute_subnetwork.proxy_only]

  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  target                = google_compute_target_https_proxy.default.id
  # network               = google_compute_network.vpc_network.id
  ip_address            = google_compute_global_address.default.id
}
resource "google_dns_record_set" "webapp_dns" {
  name        = var.dns_name
  type        = var.dns_type
  ttl         = var.dns_ttl
  managed_zone = var.dns_zone

  rrdatas = [ google_compute_global_forwarding_rule.default.ip_address]
}
