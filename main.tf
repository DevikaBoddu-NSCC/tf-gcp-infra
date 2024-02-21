provider "google" {
  project = var.project
  region  = var.region
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

resource "google_compute_instance" "webapp_vm_instance" {
  name          = var.webapp_vm_instance
  machine_type  = var.machine_type
  zone          = var.zone
  boot_disk {
    initialize_params {
      image = var.image
      size = var.size
      type = var.type
    }
  }
  network_interface {
    network       = google_compute_network.vpc_network.id
    subnetwork    = google_compute_subnetwork.webapp_subnet.id
    access_config {}
  }
  tags     = var.tags
  service_account {
    email  = var.service_account_email
    scopes = var.scopes
  }
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
resource "google_compute_firewall" "deny_ssh" {
  name    = var.deny_ssh
  network = google_compute_network.vpc_network.id
  deny {
    protocol = var.protocol
    ports    = var.port_deny
  }
  source_ranges = var.source_ranges
}
