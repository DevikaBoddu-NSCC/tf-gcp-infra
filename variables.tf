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
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
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
  default     = "packer-1708536057"
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