# tf-gcp-infra

assignment 3- cloud computing   

Prerequisites
* 		Terraform: Install Terraform  
*       gcloud cli : Install gcloud cli  
*       Create gcloud project using cli or console : gcloud projects create web-project-370718 
*       Perform these steps to connect to the gcp console - 
                *       gcloud auth login 
                *       gcloud auth application-default login 
                *       gcloud config set project 
* 		Provider Credentials: Configure provider credentials in Terraform configuration file main.tf. 
  
Steps 
* 		Clone the Repository: git clone git@github.com:DevikaBoddu13/tf-gcp-infra.git  
* 		Initialize Terraform: terraform init 
* 		Review Configuration: Configure main.tf with infrastructure setup.
* 		Plan Infrastructure Changes: Run terraform plan to see what changes will be applied
* 		Apply Infrastructure Changes: If the plan looks good, apply the changes: terraform apply
* 		Verify Infrastructure: After applying changes, verify that the infrastructure has been provisioned correctly using gcp console.
* 		Destroy Infrastructure (Optional): terraform destroy


provider "google" {
  credentials = file(var.credentials)
  project     = var.project_id
  region      = var.region
}

resource "google_compute_network" "vpc_network" {
  name                            = var.vpc_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.route_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

resource "google_compute_subnetwork" "webapp" {
  name          = var.webapp_subnet_name
  ip_cidr_range = var.webapp_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "db" {
  name          = var.db_subnet_name
  ip_cidr_range = var.db_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_route" "webapp_internet_route" {
  name             = var.webapp_route_name
  dest_range       = var.dest_range
  network          = google_compute_network.vpc_network.id
  next_hop_gateway = var.next_hop_gateway
}

resource "google_compute_firewall" "allow_http" {
  name    = var.allow_http
  network = google_compute_network.vpc_network.name

  allow {
    protocol = var.protocol
    ports    = var.ports
  }

  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}

resource "google_compute_instance" "webapp_vm" {
  name         = var.webapp_vm_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = var.image
      size = var.size
      type = var.type
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.webapp.self_link

    access_config {
      // Ephemeral IP assigned
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = var.scopes
  }
}