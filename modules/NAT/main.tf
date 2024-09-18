resource "google_compute_router" "nat_router" {
  name    = var.router_name
  network = var.vpc_name
  region  = var.region_name
}

  resource "google_compute_router_nat" "nat_gateway" {
  name     = "nat-gateway"
  router   = google_compute_router.nat_router.name
  region   = var.region_name

  nat_ip_allocate_option = "AUTO_ONLY"  # Allocate a public IP automatically
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"  # NAT for private subnets

  # Allow subnetnetwork block if you are using LIST_OF_SUBNETWORKS instead of "ALL_SUBNETWORKS_ALL_IP_RANGES"
  #subnetwork {
  #  name                    = var.private_subnet-name
  #  source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  #}
}
