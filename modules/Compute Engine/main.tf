# Compute Engine main.tf file

resource "google_compute_instance" "gce" {
  name = element(var.inst_name, count.index)    
  machine_type = element(var.inst_type,count.index)
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

