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

