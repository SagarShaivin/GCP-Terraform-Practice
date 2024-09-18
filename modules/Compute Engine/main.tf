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

    # Conditionally add public IP (access_config block)
    dynamic "access_config" {
      for_each = var.assign_public_ip && var.static_ip != "" ? [1] : []
      content {
        nat_ip = var.static_ip
      }
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key)}"
  }

}

