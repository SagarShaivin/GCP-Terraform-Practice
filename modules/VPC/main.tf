# VPC Module

resource "google_compute_network" "vpc" {
  name = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  count = var.no_of_subnets
  name = element(var.subnet_name, count.index)
  ip_cidr_range = element(var.subnet_iprange, count.index)
  region = element(var.region_name, count.index)
  network = google_compute_network.vpc.name
  private_ip_google_access = true
} 