# Compute Engine main.tf file

resource "google_compute_instance" "gce" {
  name = var.inst_name
  machine_type = var.inst_type
  zone = var.zone_name
  
  boot_disk {
    initialize_params {
      image = var.image_type 

    }
  }

  tags = var.tags

  allow_stopping_for_update = true

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

