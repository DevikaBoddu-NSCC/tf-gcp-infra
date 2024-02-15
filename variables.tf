variable "project" {
  description = "The Google Cloud project ID"
  type        = string
  default     = "web-project-370718"
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The Google Cloud zone"
  type        = string
  default     = "us-central1-c"
}

variable "vpc_name" {
  description = "The Google Cloud vpc"
  type        = string
  default     = "us-central1-c"
}
variable "webapp_subnet" {
  description = "The Google Cloud webapp subnet"
  type        = string
  default     = "us-central1-c"
}

variable "db_subnet" {
  description = "The Google Cloud db subnet"
  type        = string
  default     = "us-central1-c"
}

variable "webapp_ip_cidr_range" {
  description = "The Google Cloud webapp subnet ip_cidr_range"
  type        = string
  default     = "us-central1-c"
}

variable webapp_route_name {
    description = "Describes the webapp subnet route"
    type        = string
    default     = "us-central1-c"
}

variable "db_ip_cidr_range" {
  description = "The Google Cloud db subnet ip_cidr_range"
  type        = string
  default     = "us-central1-c"
}

variable "auto_create_subnetworks" {
  description = "Describes that auto_create_subnetworks should be created automatically"
  type        = string
  default     = "us-central1-c"
}

variable "delete_default_routes_on_create" {
  description = "Describes that delete_default_routes_on_create should be created automatically"
  type        = string
  default     = "us-central1-c"
}

variable "dest_range" {
  description = "Describes the destination range"
  type        = string
  default     = "us-central1-c"
}

variable "next_hop_gateway" {
  description = "Describes the next hop gateway for the webapp internet route"
  type        = string
  default     = "us-central1-c"
}

variable "route_mode" {
  description = "Describes the route mode"
  type        = string
  default     = "us-central1-c"
}