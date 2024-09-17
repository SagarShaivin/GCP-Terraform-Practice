# VPC Module

resource "google_compute_network" "vpc" {
  name = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  
  name = var.subnet_name
  ip_cidr_range = var.subnet_iprange
  region = var.region_name
  network = google_compute_network.vpc.name
  private_ip_google_access = true
} 

