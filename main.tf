# GCP Provider

provider "google" {
  credentials = file(var.triage_1_terraform_key)
  project = var.gcp_project_id
}

#module "vpc-1" {
#  source = "./modules/VPC"
#  network_name = "vpc-1"
#  no_of_subnets = 2
#  subnet_name = ["subnet-1", "subnet-2"]
#  subnet_iprange = ["10.0.1.0/24", "10.0.2.0/24"]
#  region_name = ["us-central1", "us-west2"]
#}

module "gce-1" {
  source = "./modules/Compute Engine"
  inst_name = ["instance-1"]
  inst_type = "e2-medium"
  zone_name = ["us-central1-a"]
  no_of_inst = 1
  image_type = "ubuntu-os-cloud/ubuntu-2204-lts"
  tags = ["tag-1"]
  ssh_user = var.ssh_user
  ssh_public_key = var.ssh_public_key
}