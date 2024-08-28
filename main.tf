# GCP Provider
provider "google" {
  credentials = file(var.triage_1_terraform_key)
  project = var.gcp_project_id
  region = var.gcp_region
}

module "gce-1" {
  source = "./modules/Compute Engine"
  inst_name = ["instance-1", "instance-2"]
  inst_type = "e2-medium"
  zone_name = ["us-central1-a", "us-central1-b"]
  no_of_inst = 2
  image_type = "ubuntu-os-cloud/ubuntu-2204-lts"

}