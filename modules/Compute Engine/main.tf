# Compute Engine main.tf file

resource "google_compute_instance" "gce" {
  name = element(var.inst_name, count.index)    
  machine_type = var.inst_type
  zone = element(var.zone_name, count.index)
  count = var.no_of_inst
  
  boot_disk {
    initialize_params {
      image = var.image_type 

    }
  }

  tags = var.tags

  network_interface {
    network = var.vpc_network
    subnetwork = var.vpc_subnetwork

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key)}"
  }

}

resource "google_compute_firewall" "allow-http" {
  name    = "allow-custom-port"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "8000"]
  }

  source_ranges = ["0.0.0.0/0"]  

  target_tags = var.tags
}
