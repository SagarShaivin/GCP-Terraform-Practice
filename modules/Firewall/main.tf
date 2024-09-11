resource "google_compute_firewall" "allow-http" {
  name    = var.firewall_name
  network = var.target_vpc

  allow {
    protocol = var.protocol_type
    ports    = var.allowed_ports
  }

  source_ranges = var.allowed_iprange  

  target_tags = var.target_instances
}
