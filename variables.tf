variable "project" {
  description = "The Google Cloud project ID"
  type        = string
  default     = "dev-csye6225-415809"
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "us-east1"
}
variable "zone" {
  description = "The Google Cloud zone"
  type        = string
  default     = "us-east1-b"
}

variable "vpc_name" {
  description = "The Google Cloud vpc"
  type        = string
  default     = "vpc-network"
}

variable "webapp_subnet" {
  description = "The Google Cloud webapp subnet"
  type        = string
  default     = "webapp-subnet"
}

variable "db_subnet" {
  description = "The Google Cloud db subnet"
  type        = string
  default     = "db-subnet"
}

variable "webapp_ip_cidr_range" {
  description = "The Google Cloud webapp subnet ip_cidr_range"
  type        = string
  default     = "10.0.0.0/24"
}

variable "webapp_route_name" {
  description = "Describes the webapp subnet route"
  type        = string
  default     = "webapp-route-name"
}

variable "db_ip_cidr_range" {
  description = "The Google Cloud db subnet ip_cidr_range"
  type        = string
  default     = "10.0.1.0/24"
}

variable "auto_create_subnetworks" {
  description = "Describes that auto_create_subnetworks should be created automatically"
  type        = bool
  default     = false
}

variable "delete_default_routes_on_create" {
  description = "Describes that delete_default_routes_on_create should be created automatically"
  type        = bool
  default     = true
}

variable "dest_range" {
  description = "Describes the destination range"
  type        = string
  default     = "0.0.0.0/0"
}

variable "next_hop_gateway" {
  description = "Describes the next hop gateway for the webapp internet route"
  type        = string
  default     = "default-internet-gateway"

}

variable "route_mode" {
  description = "Describes the route mode"
  type        = string
  default     = "REGIONAL"
}

variable "webapp_vm_instance" {
  description = "Describes the webapp instance"
  type        = string
  default     = "webapp-vm"
}

variable "service_account_email" {
  description = "Describes the service_account_email"
  type        = string
  default     = "dev-nscc"
}

variable "scopes" {
  description = "Describes the scopes"
  type        = list(string)
  default     = ["cloud-platform"]
}

variable "type" {
  description = "Describes the type of the instance"
  type        = string
  default     = "pd-balanced"
}

variable "size" {
  description = "Describes the size of the instance"
  type        = number
  default     = 100
}

variable "image" {
  description = "Describes the image"
  type        = string
  default     = "packer-1710914375"
}

variable "tags" {
  description = "Describes the tags"
  type        = list(string)
  default     = ["http-server"]
}

variable "machine_type" {
  description = "Describes the machine_type"
  type        = string
  default     = "e2-medium"
}

variable "target_tags" {
  description = "Describes the target_tags"
  type        = list(string)
  default     = ["http-server"]
}

variable "source_ranges" {
  description = "Describes the source_ranges"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "port_allow" {
  description = "Describes the ports"
  type        = list(string)
  default     = ["3000"]
}

variable "port_deny" {
  description = "Describes the port_deny"
  type        = list(string)
  default     = ["22"]
}

variable "protocol" {
  description = "Describes the protocol"
  type        = string
  default     = "tcp"
}

variable "allow_http" {
  description = "Describes the allow_http firewall"
  type        = string
  default     = "allow-http"
}

variable "deny_ssh" {
  description = "Describes the deny_ssh firewall"
  type        = string
  default     = "deny-ssh"
}
variable "my_ip_address" {
  description = "Describes the my_ip_address"
  type        = list(string)
  default     = ["73.218.147.89"]
}

variable "allow_ssh_from_my_ip" {
  description = "Describes the allow_ssh_from_my_ip"
  type        = string
  default     = "allow-ssh-from-my-ip"
}

variable "image_family" {
  description = "Describes the image_family"
  type        = string
  default     = "centos-stream-8"
}
variable "ssh_pub_key_file" {
  description = "Describes the ssh_pub_key_file"
  type        = string
  default     = "/Users/devikaboddu/Desktop/CC/Assignment4/key.pub"
}
variable "ssh_user" {
  description = "Describes the ssh_user"
  type        = string
  default     = "centos"
}
#assignment4
variable "cloud_sql_instance" {
  description = "Describes the cloud_sql_instance"
  default = "cloud-sql-instance"
}
variable "private_ip_address" {
  description = "Describes the private_ip_address"
  default = "private-ip-address"
}
variable "purpose" {
  description = "Describes the purpose of private-ip-address"
  default = "VPC_PEERING"
}
variable "address_type" {
  description = "Describes the address_type"
  default     = "INTERNAL"
}
variable "prefix_length" {
  description = "Describes the prefix_length"
  default = 16
}
variable "service" {
  description = "Describes the service"
  default = "servicenetworking.googleapis.com"
}
variable "tier_sql" {
  description = "Describes the tier"
  default = "db-f1-micro"
}
variable "disk_type_sql" {
  description = "Describes the disk_type_sql"
  default = "PD_SSD"
}
variable "disk_size_sql" {
  description = "Describes the disk_size_sql"
  default=100
}
variable "availability_type_sql" {
  description = "Describes the availability_type_sql"
  default     = "REGIONAL"
}
variable "ipv4_enabled" {
  description = "Describes the ipv4_enabled"
  default     = false
}
variable "deletion_protection" {
  description = "Describes the deletion_protection"
  default     = false
}
variable "database_name" {
  description = "Describes the database_name"
  default     = "webapp"
}
variable "db_user_name" {
  description = "Describes the db_user_name"
  default     = "webapp"
}
variable "db_dialect" {
  description = "db_dialect"
  default     = "mysql"
}
variable "deletion_policy" {
  description = "Describes the deletion_policy"
  default     = "ABANDON"
}
variable "database_version" {
  description = "Describes the database_version"
  default     = "MYSQL_5_7"
}
variable "allow_sql_access" {
  description = "Describes the allow_sql_access"
  default     = "allow-sql-access"
}
variable "deny_all_sql_traffic" {
  description = "Describes the deny_all_sql_traffic"
  default     = "deny-all-sql-traffic"
}
variable "db_port" {
  description = "Describes the database_port"
  default     = ["3306"]
}

variable "webapp_subnet_range" {
  description = "Describes the webapp_subnet_range"
  default     = ["10.0.0.0/24"]
}
variable "account_id" {
  description = "Describes the account_id"
  default     = "csye6225-vm-service-account"
}
variable "display_name" {
  description = "Describes the display_name"
  default     = "Custom service account for webapp"
}
variable "dns_name" {
  description = "Describes the dns_name"
  default     = "devikaboddu-csye6225.me."
}
variable "dns_type" {
  description = "Describes the dns_type"
  default     = "A"
}
variable "dns_ttl" {
  description = "Describes the dns_ttl"
  default     = 30
}
variable "dns_zone" {
  description = "Describes the dns_zone"
  default     = "csye6225-zone"
}

variable "role_serviceAccountUser" {
  description = "Describes the role serviceAccountUser"
  default     = "roles/iam.serviceAccountUser"
}
variable "role_loggingadmin" {
  description = "Describes the role logging.admin"
  default     = "roles/logging.admin"
}
variable "role_monitoringmetricWriter" {
  description = "Describes the role monitoring.metricWriter"
  default     = "roles/monitoring.metricWriter"
}
//assignment 7

variable "cloud_trigger_topic_name"{
  description = "Describes the cloud_trigger_topic_name"
  default     = "verify_email"
}

variable "location"{
  description = "Describes the location"
  default     = "US"
}
variable "role_pubsubpublisher" {
  description = "Describes the role pubsub.publisher"
  default     = "roles/pubsub.publisher"
}
variable "function_name" {
  description = "Name of the Cloud Function"
  default     = "gcf-function"
}

variable "function_description" {
  description = "Description of the Cloud Function"
  default     = "email delivery function"
}

variable "function_runtime" {
  description = "Runtime environment for the Cloud Function"
  default     = "nodejs20"
}

variable "function_entry_point" {
  description = "Entry point class or method for the Cloud Function"
  default     = "helloPubSub"
}

variable "function_max_instance_count" {
  description = "Maximum number of instances for the Cloud Function"
  default     = 3
}

variable "function_min_instance_count" {
  description = "Minimum number of instances for the Cloud Function"
  default     = 1
}

variable "function_available_memory" {
  description = "Available memory for each instance of the Cloud Function"
  default     = "256Mi"
}

variable "function_timeout_seconds" {
  description = "Timeout duration (in seconds) for the Cloud Function"
  default     = 60
}

variable "function_max_instance_request_concurrency" {
  description = "Maximum number of concurrent requests per instance for the Cloud Function"
  default     = 1
}

variable "function_available_cpu" {
  description = "Available CPU for each instance of the Cloud Function"
  default     = "167m"
}

variable "function_api_key" {
  description = "MAIL_GUN_API key for the Cloud Function"
  default     = "53952361e705a695f3abbd0a7f7474d9-f68a26c9-cb707263"
}

variable "function_vpc_connector_egress_settings" {
  description = "Egress settings for the VPC connector"
  default     = "PRIVATE_RANGES_ONLY"
}

variable "function_ingress_settings" {
  description = "Ingress settings for the Cloud Function"
  default     = "ALLOW_ALL"
}

variable "function_all_traffic_on_latest_revision" {
  description = "Whether to route all traffic to the latest revision of the Cloud Function"
  default     = true
}

variable "function_event_type" {
  description = "Event type for the Cloud Function trigger"
  default     = "google.cloud.pubsub.topic.v1.messagePublished"
}

variable "function_retry_policy" {
  description = "Retry policy for the Cloud Function trigger"
  default     = "RETRY_POLICY_DO_NOT_RETRY"
}

variable "connector_name" {
  description = "Name of the VPC Access Connector"
  default     = "vpc-connector-serverless"
}

variable "connector_ip_cidr_range" {
  description = "IP CIDR range for the VPC Access Connector"
  default     = "10.8.0.0/28"
}

variable "object_name" {
  description = "Name of the storage bucket object"
  default     = "devikabucket/output.zip"
}

variable "object_source_path" {
  description = "Local path to the zipped function source code"
  default     = "/Users/devikaboddu/Desktop/CC/Assignment7/serverless/output.zip" 
} 

//assignment 8

variable "instance_template_name_prefix" {
  description = "The name prefix of the instance template"
  type        = string
  default     = "csye6225-instance-template-"
}

variable "instance_template_description" {
  description = "The description of the instance template"
  type        = string
  default     = "instance template"
}

variable "instance_group_manager_name" {
  description = "The name of the instance group manager"
  type        = string
  default     = "csye6225-instance-group-manager" 
}

variable "named_port_name" {
  description = "The name of the named port"
  type        = string
  default     = "http" 
}

variable "named_port_port" {
  description = "The port number of the named port"
  type        = number
  default     = 3000 
}

variable "base_instance_name" {
  description = "The name of the base_instance"
  type        = string
  default     = "instance-group-manager"
}
variable "initial_delay_sec" {
  description = "The name of the base_instance"
  type        = number
  default     = 600
}

variable "health_check_name" {
  description = "The name of the health check"
  type        = string
  default     = "lb-health-check" 
}

variable "check_interval_sec" {
  description = "The interval between health checks"
  type        = number
  default     = 20 
}

variable "healthy_threshold" {
  description = "The number of consecutive successful health checks to consider the instance healthy"
  type        = number
  default     = 5 
}

variable "timeout_sec" {
  description = "The timeout for each health check request"
  type        = number
  default     = 5 
}

variable "unhealthy_threshold" {
  description = "The number of consecutive failed health checks to consider the instance unhealthy"
  type        = number
  default     = 5 
}
variable "webapp_healthcheck_port"{
  description = "The port on which the health check will be performed"
  default     = 3000
}
variable "webapp_port" {
  description = "The port on which the health check will be performed"
  default     = ["3000"]
}

variable "port_specification" {
  description = "The specification for the port used in the health check"
  type        = string
  default     = "USE_FIXED_PORT" 
}

variable "proxy_header" {
  description = "The proxy header used in the health check"
  type        = string
  default     = "NONE" 
}

variable "request_path" {
  description = "The request path used in the health check"
  type        = string
  default     = "/healthz" 
}
variable "autoscaler_name" {
  description = "The name of the autoscaler"
  type        = string
  default     = "csye6225-region-autoscaler" 
}

variable "autoscaling_max_replicas" {
  description = "The maximum number of replicas for autoscaling"
  type        = number
  default     = 3 
}

variable "autoscaling_min_replicas" {
  description = "The minimum number of replicas for autoscaling"
  type        = number
  default     = 1  
}

variable "autoscaling_cooldown_period" {
  description = "The cooldown period for autoscaling"
  type        = number
  default     = 180  
}

variable "autoscaling_mode" {
  description = "The autoscaling mode"
  type        = string
  default     = "ON"  
}

variable "cpu_utilization_target" {
  description = "The target CPU utilization for autoscaling"
  type        = number
  default     = 0.05  
}

variable "global_address_name" {
  description = "The name of the global address"
  type        = string
  default     = "lb-ip-address"  
}

variable "global_address_type" {
  description = "The type of the global address"
  type        = string
  default     = "EXTERNAL" 
}

variable "subnetwork_name" {
  description = "The name of the subnetwork which assigns IP addresses to instances"
  type        = string
  default     = "proxy-only-subnet" 
}

variable "proxy_subnetwork_ip_cidr_range_string" {
  description = "The IP CIDR range for the subnetwork"
  default     = "10.129.0.0/23"
}
variable "proxy_subnetwork_ip_cidr_range" {
  description = "The IP CIDR range for the subnetwork"
  type        = set(string)   
  default     = ["10.129.0.0/23"]   
}

variable "subnetwork_purpose" {
  description = "The purpose of the subnetwork"
  type        = string
  default     = "REGIONAL_MANAGED_PROXY"
}

variable "subnetwork_role" {
  description = "The role of the subnetwork"
  type        = string
  default     = "ACTIVE" 
}

variable "firewall_health_check_name" {
  description = "The name of the health check firewall"
  type        = string
  default     = "fw-allow-health-check" 
}

variable "firewall_allow_protocol" {
  description = "The protocol allowed by the firewall"
  type        = string
  default     = "tcp" 
}

variable "firewall_direction" {
  description = "The direction of the firewall rule"
  type        = string
  default     = "INGRESS"
}

variable "firewall_priority" {
  description = "The priority of the firewall rule"
  type        = number
  default     = 1000 
}

variable "firewall_source_ranges_health_check" {
  description = "The source IP ranges allowed by the health check firewall rule"
  type        = list(string)
  default     = ["130.211.0.0/22", "35.191.0.0/16"] 
}

variable "lb_target_tags" {
  description = "The target tags allowed by the health check firewall rule"
  type        = list(string)
  default     = ["load-balanced-backend"] 
}

variable "firewall_proxy_name" {
  description = "The name of the proxy firewall"
  type        = string
  default     = "fw-allow-proxies" 
}
variable "http_port" {
  description = "The port allowed by the proxy firewall rule"
  default     = ["80"]
}

variable "backend_service_name" {
  description = "The name of the backend service"
  type        = string
  default     = "webapp-backend-service" 
}

variable "backend_service_load_balancing_scheme" {
  description = "The load balancing scheme for the backend service"
  type        = string
  default     = "EXTERNAL" 
}

variable "backend_service_protocol" {
  description = "The protocol used by the backend service"
  type        = string
  default     = "HTTP" 
}

variable "backend_service_session_affinity" {
  description = "The session affinity setting for the backend service"
  type        = string
  default     = "NONE" 
}

variable "backend_service_timeout_sec" {
  description = "The timeout in seconds for requests to the backend service"
  type        = number
  default     = 30 
}

variable "backend_service_balancing_mode" {
  description = "The balancing mode for the backend service"
  type        = string
  default     = "UTILIZATION" 
}

variable "backend_service_capacity_scaler" {
  description = "The capacity scaler for the backend service"
  type        = number
  default     = 1.0 
}
variable "lb_url_map_name" {
  description = "The name of the URL map"
  type        = string
  default     = "lb-url-map" 
}
variable "target_https_proxy_name" {
  description = "The name of the target HTTPS proxy"
  type        = string
  default     = "myservice-https-proxy" 
}

variable "forwarding_rule_name" {
  description = "The name of the forwarding rule"
  type        = string
  default     = "lb-forwarding-rule"  
}

variable "provider_beta" {
  description = "The provider for the forwarding rule"
  type        = string
  default     = "google-beta" 
}

variable "forwarding_rule_ip_protocol" {
  description = "The IP protocol for the forwarding rule"
  type        = string
  default     = "TCP" 
}

variable "forwarding_rule_load_balancing_scheme" {
  description = "The load balancing scheme for the forwarding rule"
  type        = string
  default     = "EXTERNAL"
}

variable "forwarding_rule_port_range" {
  description = "The port range for the forwarding rule"
  type        = string
  default     = "443" 
}

variable "ssl_certificate_name" {
  description = "The name of the SSL certificate"
  type        = string
  default     = "csye6225-ssl-cert" 
}

variable "ssl_certificate_domain" {
  description = "The list of domains for the SSL certificate"
  default     = ["devikaboddu-csye6225.me"]
}
//assignment9
variable "role_cryptoKeyEncrypterDecrypter" {
  description = "Describes the role cryptoKeyEncrypterDecrypter"
  default     = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
}
variable "role_cloudkmsadmin" {
  description = "Describes the role cloudkms.admin"
  default     = "roles/cloudkms.admin"
}

variable "rotation_period" {
  description = "The value of rotation_period"
  type        = string
  default     = "2592000s" 
}

variable "vm_crypto_key_name" {
  description = "The value of vm_crypto_key_name"
  type        = string
  default     = "vm_crypto_key"
}
variable "cloudsql_crypto_key_name" {
  description = "The value of cloudsql_crypto_key_name"
  type        = string
  default     = "cloudsql_crypto_key"
}
variable "storage_crypto_key_name" {
  description = "The value of storage_crypto_key_name"
  type        = string
  default     = "storage_crypto_key"
}

variable "key_purpose" {
  description = "The value of key_purpose"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "vm_service_account_email" {
  description = "Describes the service_account_email"
  type        = string
  default     = "service-30489356583@compute-system.iam.gserviceaccount.com"
}
variable "cloudsql_service_account_email" {
  description = "Describes the service_account_email"
  type        = string
  default     = "service-30489356583@gcp-sa-cloud-sql.iam.gserviceaccount.com"
}
variable "storage_service_account_email" {
  description = "Describes the service_account_email"
  type        = string
  default     = "service-30489356583@gs-project-accounts.iam.gserviceaccount.com"
}