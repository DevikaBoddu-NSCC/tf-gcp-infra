variable "project" {
  description = "The Google Cloud project ID"
  type        = string
  default     = "dev-nscc"
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

variable webapp_route_name {
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
  type        = string
  default     = "false"
}

variable "delete_default_routes_on_create" {
  description = "Describes that delete_default_routes_on_create should be created automatically"
  type        = string
  default     = "true"
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
}
variable "scopes" {
  description = "Describes the scopes"
}
variable "type" {
  description = "Describes the type of the instance"
}
variable "size" {
  description = "Describes the size of the instance"
}
variable "image" {
  description = "Describes the image"
}
variable "tags" {
  description = "Describes the tags"
}
variable "machine_type" {
  description = "Describes the machine_type"
}
variable "target_tags" {
  description = "Describes the target_tags"
}
variable "source_ranges" {
  description = "Describes the source_ranges"
}
variable "port_allow" {
  description = "Describes the ports"
}
variable "port_deny" {
  description = "Describes the port_deny"
}
variable "protocol" {
  description = "Describes the protocol"
}
variable "allow_http" {
  description = "Describes the allow_http firewall"
}
variable "deny_ssh" {
  description = "Describes the deny_ssh firewall"
}
# variable "webapp_external_ip"{
#   description = "Describes the webapp_external_ip"
# }

# variable "external_ip_name"{
#   description = "Describes the external_ip_name"
# }