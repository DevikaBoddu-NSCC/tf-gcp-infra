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
  target_tags   = var.lb_target_tags
}
resource "google_compute_firewall" "allow_ssh_from_my_ip" {
  name    = var.allow_ssh_from_my_ip
  network = google_compute_network.vpc_network.id

  allow {
    protocol = var.protocol
    ports    = var.port_deny
  }

  source_ranges = var.my_ip_address
  target_tags   = var.lb_target_tags
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
  encryption_key_name = google_kms_crypto_key.cloudsql_crypto_key.id
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
  
  depends_on = [google_service_networking_connection.default, google_kms_crypto_key_iam_binding.binding_cloudsql_instance, google_kms_crypto_key.cloudsql_crypto_key]
}

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.cloud_sql_instance.id
}
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "-@&4"
}
resource "google_sql_user" "db_user" {
  name     = var.db_user_name
  host     = "%"
  instance = google_sql_database_instance.cloud_sql_instance.id
  password = random_password.password.result
}

# resource "google_compute_instance" "webapp_vm_instance" {
#   name         = var.webapp_vm_instance
#   machine_type = var.machine_type
#   zone         = var.zone
#   allow_stopping_for_update = true 
#   boot_disk {
#     initialize_params {
#       image = data.google_compute_image.latest_custom_image.self_link
#       size  = var.size
#       type  = var.type
#     }
#   }
#   network_interface {
#     network    = google_compute_network.vpc_network.id
#     subnetwork = google_compute_subnetwork.webapp_subnet.id
#     access_config {}
#   }
#   tags = var.tags
#   service_account {
#     email  = google_service_account.service_account.email
#     scopes = var.scopes
#   }
  # metadata = {
  #   ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  #   startup-script = <<-EOT
  #       #!/bin/bash
  #       ENV_FILE="/opt/csye6225/webapp/.env"
  #       if [ -e "$ENV_FILE" ]; then
  #           sed -i '1iLOGPATH=/var/log/webapp/' "$ENV_FILE"
  #           sed -i 's/^DB_HOST=.*/DB_HOST=${google_sql_database_instance.cloud_sql_instance.ip_address.0.ip_address}/' "$ENV_FILE"
  #           sed -i 's/^DB_USERNAME=.*/DB_USERNAME=${google_sql_user.db_user.name}/' "$ENV_FILE"
  #           sed -i 's/^DB_PASSWORD=.*/DB_PASSWORD=${google_sql_user.db_user.password}/' "$ENV_FILE"
  #           sed -i 's/^DB_NAME=.*/DB_NAME=${google_sql_database.database.name}/' "$ENV_FILE"
  #           echo "$ENV_FILE"
  #       fi
  #       sudo chown -R csye6225:csye6225 /opt/csye6225/
  #       sudo chown -R csye6225:csye6225 /var/log/webapp/
  #       sudo systemctl restart webapp
  #     EOT
  # }

#   depends_on = [google_service_networking_connection.default, google_service_account.service_account]
# }
resource "google_compute_firewall" "allow_sql_access" {
  name    = var.allow_sql_access
  network = google_compute_network.vpc_network.id

  allow {
    protocol = var.protocol
    ports    = var.db_port
  }

  source_ranges = var.proxy_subnetwork_ip_cidr_range
  destination_ranges = ["${google_compute_global_address.private_ip_address.address}/16"]
  target_tags   = var.lb_target_tags
}
//assignment6

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
//assignment7
resource "google_project_iam_binding" "pub_sub_publisher" {
  project = var.project
  role    = var.role_pubsubpublisher

  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}
resource "google_pubsub_topic" "cloud_trigger_topic" {
  name = var.cloud_trigger_topic_name
}
resource "google_storage_bucket" "bucket" {
  name                        = "${var.project}-gcf-source" 
  location                     = "us-east1"
  uniform_bucket_level_access = true
  depends_on = [ google_kms_crypto_key_iam_binding.binding_storage_bucket ]
  encryption {
    default_kms_key_name = google_kms_crypto_key.storage_crypto_key.id
  }

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
  depends_on  = [google_vpc_access_connector.connector1]

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
      DB_HOST       = google_sql_database_instance.cloud_sql_instance.ip_address.0.ip_address
      DB_NAME       = google_sql_database.database.name
      DB_DIALECT    = var.db_dialect
    }
    vpc_connector                  = google_vpc_access_connector.connector1.name
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

resource "google_vpc_access_connector" "connector1" {
  name          = var.connector_name
  ip_cidr_range = var.connector_ip_cidr_range
  network       = google_compute_network.vpc_network.name
  region        = var.region
}
//assignment8
resource "google_compute_region_instance_template" "instance_template" {
  name_prefix  = var.instance_template_name_prefix
  description = var.instance_template_description
  machine_type = var.machine_type

  // boot disk
  disk {
      source_image = data.google_compute_image.latest_custom_image.self_link
      type  = var.type
      disk_encryption_key {
        kms_key_self_link = google_kms_crypto_key.vm_crypto_key.id
      }

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

  depends_on = [google_service_networking_connection.default, google_service_account.service_account, google_kms_crypto_key_iam_binding.binding_vm_instance]

  lifecycle {
    create_before_destroy = true
  }
  tags = var.lb_target_tags
}
resource "google_compute_region_instance_group_manager" "instance_group_manager" {
  name               = var.instance_group_manager_name
  named_port {
    name = var.named_port_name
    port = var.named_port_port
  }
  version {
    instance_template = google_compute_region_instance_template.instance_template.self_link
  }
  base_instance_name = var.base_instance_name
  auto_healing_policies {
    health_check      = google_compute_health_check.http.id
    initial_delay_sec = var.initial_delay_sec
  }
}
resource "google_compute_health_check" "http" {
  name               = var.health_check_name
  check_interval_sec = var.check_interval_sec
  healthy_threshold  = var.healthy_threshold
  timeout_sec         = var.timeout_sec
  unhealthy_threshold = var.unhealthy_threshold
  http_health_check {
    port               = var.webapp_healthcheck_port //3000
    port_specification = var.port_specification
    proxy_header       = var.proxy_header
    request_path       = var.request_path
  }
}

resource "google_compute_region_autoscaler" "autoscaler" {
  name   = var.autoscaler_name
  region = var.region
  target = google_compute_region_instance_group_manager.instance_group_manager.id

  autoscaling_policy {
    max_replicas    = var.autoscaling_max_replicas
    min_replicas    = var.autoscaling_min_replicas
    cooldown_period = var.autoscaling_cooldown_period
    mode            = var.autoscaling_mode
    cpu_utilization {
      target = var.cpu_utilization_target
    }
  }
}

resource "google_compute_managed_ssl_certificate" "ssl" {
  provider = google-beta
  name     = var.ssl_certificate_name

  managed {
    domains = var.ssl_certificate_domain
  }
}

//load-balancer
resource "google_compute_global_address" "default" {
  name         = var.global_address_name
  address_type = var.global_address_type
}
resource "google_compute_subnetwork" "proxy_only" {
  name          = var.subnetwork_name
  ip_cidr_range = var.proxy_subnetwork_ip_cidr_range_string
  network       = google_compute_network.vpc_network.id
  purpose       = var.subnetwork_purpose
  region        = var.region
  role          = var.subnetwork_role
}

resource "google_compute_firewall" "default" {
  name = var.firewall_health_check_name
  allow {
    protocol =  var.firewall_allow_protocol
  }
  direction     = var.firewall_direction
  network       = google_compute_network.vpc_network.id
  priority      = var.firewall_priority
  source_ranges = var.firewall_source_ranges_health_check
  target_tags   = var.lb_target_tags
}
resource "google_compute_firewall" "allow_proxy" {
  name = var.firewall_proxy_name
  allow {
    ports    = var.http_port //80
    protocol =  var.firewall_allow_protocol
  }
  allow {
    ports    = var.webapp_port //3000
    protocol =  var.firewall_allow_protocol
  }
  direction     = var.firewall_direction
  network       = google_compute_network.vpc_network.id
  priority      = var.firewall_priority
  source_ranges = var.proxy_subnetwork_ip_cidr_range
  target_tags   = var.lb_target_tags
}

resource "google_compute_backend_service" "default" {
  name                  = var.backend_service_name
  load_balancing_scheme = var.backend_service_load_balancing_scheme
  health_checks         = [google_compute_health_check.http.id]
  protocol              = var.backend_service_protocol
  session_affinity      = var.backend_service_session_affinity
  timeout_sec           = var.backend_service_timeout_sec
  backend {
    group           = google_compute_region_instance_group_manager.instance_group_manager.instance_group
    balancing_mode  = var.backend_service_balancing_mode
    capacity_scaler = var.backend_service_capacity_scaler
  }
}


resource "google_compute_url_map" "default" {
  name            = var.lb_url_map_name
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_https_proxy" "default" {
  provider = google-beta
  name     = var.target_https_proxy_name
  url_map  = google_compute_url_map.default.id
  ssl_certificates = [
    google_compute_managed_ssl_certificate.ssl.id
    
  ]
  depends_on = [
    google_compute_managed_ssl_certificate.ssl
  ]

}
# "projects/dev-csye6225-415809/global/sslCertificates/ssl"

resource "google_compute_global_forwarding_rule" "default" {
  name       = var.forwarding_rule_name
  provider   = google-beta
  depends_on = [google_compute_subnetwork.proxy_only]

  ip_protocol           = var.forwarding_rule_ip_protocol //TCP
  load_balancing_scheme = var.forwarding_rule_load_balancing_scheme
  port_range            = var.forwarding_rule_port_range //443
  target                = google_compute_target_https_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}

resource "google_dns_record_set" "webapp_dns" {
  name        = var.dns_name
  type        = var.dns_type
  ttl         = var.dns_ttl
  managed_zone = var.dns_zone

  rrdatas = [ google_compute_global_forwarding_rule.default.ip_address]
}
//assignment9
resource "random_id" "key_name_suffix" {
  byte_length = 4
}
resource "google_kms_key_ring" "keyring" {
  provider = google-beta
  name     = "keyring-${random_id.key_name_suffix.hex}"
  location = var.region
  lifecycle {
    prevent_destroy = false
  }
}
resource "google_kms_crypto_key" "vm_crypto_key" {
  name            = var.vm_crypto_key_name
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = var.rotation_period

  lifecycle {
    prevent_destroy = false
  }
}
resource "google_kms_crypto_key" "cloudsql_crypto_key" {
  name            = var.cloudsql_crypto_key_name
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = var.rotation_period
  purpose         = var.key_purpose
  lifecycle {
    prevent_destroy = false
  }
}
resource "google_kms_crypto_key" "storage_crypto_key" {
  name            = var.storage_crypto_key_name
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = var.rotation_period
  lifecycle {
    prevent_destroy = false
  }
}
resource "google_kms_crypto_key_iam_binding" "binding_vm_instance" {
  provider      = google-beta
  crypto_key_id = google_kms_crypto_key.vm_crypto_key.id
  role          = var.role_cryptoKeyEncrypterDecrypter

  members = [
    "serviceAccount:${var.vm_service_account_email}",
  ]
}
resource "google_kms_crypto_key_iam_binding" "binding_cloudsql_instance" {
  provider      = google-beta
  crypto_key_id = google_kms_crypto_key.cloudsql_crypto_key.id
  role          = var.role_cryptoKeyEncrypterDecrypter

  members = [
    "serviceAccount:${var.cloudsql_service_account_email}",
  ]
}
resource "google_kms_crypto_key_iam_binding" "binding_storage_bucket" {
  provider      = google-beta
  crypto_key_id = google_kms_crypto_key.storage_crypto_key.id
  role    = var.role_cryptoKeyEncrypterDecrypter

  members = [
    "serviceAccount:${var.storage_service_account_email}",
  ]
  
}
resource "google_kms_crypto_key_iam_binding" "binding_storage_bucket_1" {
  provider      = google-beta
  crypto_key_id = google_kms_crypto_key.storage_crypto_key.id
  role    = var.role_cloudkmsadmin

  members = [
    "serviceAccount:${var.storage_service_account_email}",
  ]
}