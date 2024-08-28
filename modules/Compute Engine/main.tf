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
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  #metadata = {
  #  ssh-keys = <<EOF
  #shaivin-sagar:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC192QdD0Zc0KBdScClZBTQpxA4m71Cv2InDHRqya4RNCcmuqKB1tyVLnYQbGocVxPWdifUFJty2J8QOUZg5uChYp9zemmfRDKiC7yc2KtFxtygVsWQjSEh9GMmGuXzCahQgYxZmmJYvvhAyEd+WPQEe/h0bQ3CLaIS6rKFaGaUh+owY/TpTmv0VQ1byTjVZ9iJ7eiVETzgf9rC2mxrfH66Q+DDEgSsmGyH25AUagdkpPb0zAPlZWE1QhTQLWGWVzCUFCV/IfdQogE22HT1X/zZ1JFcLl3Tdjwg4kJwpvvjv64tGIYUmPFJBlSIKgiOCmoZm1sVSDMKd9tFVdOv4z5WfED6od0fA3K5D+j08mSj4IMC2wmQcUynzkGpnA/KNa1t6pqlcn2L2IzTTSOhh5MshE6LU/FTCQGtXltZRjGyMfbuquWAgrFJ5D3febbcVcVWiif2zaTSwl6GHWOeXQUwDqR1a00Opn0pTH268CqPvXv7C7hhmVeT/GeKT2dH8pk= shaivin-sagar@shaivin-sagar
  #EOF
  #}
}
