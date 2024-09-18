resource "google_compute_address" "bastion_ip" {
  name = var.static_ipname
  region = var.region_name
}