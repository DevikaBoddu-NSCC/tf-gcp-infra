variable "project" {
  description = "The Google Cloud project ID"
  type        = string
  default     = "dev-csye6225-415809"
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "us-central1"
}
variable "zone" {
  description = "The Google Cloud zone"
  type        = string
  default     = "us-central1-a"
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
  default     = "0.0.0.0/0"
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
  default     = "allow_http"
}

variable "deny_ssh" {
  description = "Describes the deny_ssh firewall"
  type        = string
  default     = "deny_ssh"
}
variable "my_ip_address" {
  description = "Describes the my_ip_address"
  type        = list(string)
  default     = ["73.218.147.89"]
}

variable "allow_ssh_from_my_ip" {
  description = "Describes the allow_ssh_from_my_ip"
  type        = string
  default     = "allow_ssh_from_my_ip"
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
}
variable "private_ip_address" {
  description = "Describes the private_ip_address"
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
  default     = "3306"
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
  default     = "gcf-function-1"
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
  default     = "devikabucket/function-source.zip"
}

variable "object_source_path" {
  description = "Local path to the zipped function source code"
  default     = "/Users/devikaboddu/Desktop/CC/Assignment7/serverless/output.zip" 
} 

//assignment 8
variable "role_networkAdmin" {
  description = "Describes the role_networkAdmin"
  default     = "roles/compute.networkAdmin"
}
variable "role_securityAdmin" {
  description = "Describes the role_securityAdmin"
  default     = "roles/compute.securityAdmin"
}
variable "role_instanceAdmin" {
  description = "Describes the role_instanceAdmin"
  default     = "roles/compute.instanceAdmin"
}