output "static_ip" {
  value = google_compute_address.bastion_ip.address
}