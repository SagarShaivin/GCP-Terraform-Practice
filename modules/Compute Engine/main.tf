resource "google_compute_instance" "gce" {
  name = element(var.inst_name, count.index)    #var.inst_name
  machine_type = var.inst_type
  zone = var.zone_name
  count = var.no_of_inst
  
  boot_disk {
    initialize_params {
      image = var.image_type #"projects/ubuntu-os-cloud/global/images/ubuntu-2204-focal-server-lts"

    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}