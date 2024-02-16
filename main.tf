provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.route_mode
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
  name        = var.webapp_route_name
  dest_range  = var.dest_range
  network     = google_compute_network.vpc_network.id
  next_hop_gateway = var.next_hop_gateway

}


