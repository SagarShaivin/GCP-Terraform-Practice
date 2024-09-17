output "private_ip" {
  value = google_compute_instance.gce.network_interface[0].network_ip
}

