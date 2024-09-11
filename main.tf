# GCP Provider

provider "google" {
  credentials = file(var.triage_1_terraform_key)
  project = var.gcp_project_id
}

# This module will create a vpc named (vpc-1)
module "vpc-1" {
  source = "./modules/VPC"
  network_name = "vpc-1"
  no_of_subnets = 2
  subnet_name = ["subnet-1", "subnet-2"]
  subnet_iprange = ["10.0.1.0/24", "10.0.2.0/24"]
  region_name = ["us-central1", "us-west2"]
  isprivate = [true, false]
}

# This module will help to create custom firewall rule, we can create multiple modules if we need 
module "firewall-1" {
  source = "./modules/Firewall"

  firewall_name = "allowed-custom-ports"
  target_vpc = module.vpc-1.network_name
  protocol_type = "tcp"
  allowed_ports = ["80","8000"]
  allowed_iprange = ["0.0.0.0/0"]
  target_instances = ["tag-1", "tag-2"]
}

module "NAT-1" {
  source = "./modules/NAT"
  router_name = "nat-router-1"
  vpc_name = module.vpc-1.network_name
  region_name = "us-central1"
  private_subnet-name = module.vpc-1.subnet_name[0]

}

module "NAT-2" {
  source = "./modules/NAT"
  router_name = "nat-router-2"
  vpc_name = module.vpc-1.network_name
  region_name = "us-west2"
  private_subnet-name = module.vpc-1.subnet_name[1]

}

# This module will create instances as per our requirement but make sure you provide proper zone,
# because the zone you will use to create the instance, then you will need to assign the instance to subnet which is also created in the same zone.
module "gce-1" {
  source = "./modules/Compute Engine"
  inst_name = ["instance-1"]
  inst_type = ["e2-medium"]
  zone_name = ["us-central1-a"]
  no_of_inst = 1
  image_type = "ubuntu-os-cloud/ubuntu-2204-lts"
  tags = ["tag-1"]
  ssh_user = var.ssh_user
  ssh_public_key = var.ssh_public_key
  vpc_network = module.vpc-1.network_name
  vpc_subnetwork = element(module.vpc-1.subnet_name,0) # subnet_name, 1 because 1 means subnet-2 and 0 means subnet-1
}

module "gce-2" {
  source = "./modules/Compute Engine"
  inst_name = ["instance-2"]
  inst_type = ["e2-medium"]
  zone_name = ["us-west2-a"]
  no_of_inst = 1
  image_type = "ubuntu-os-cloud/ubuntu-2204-lts"
  tags = ["tag-2"]
  ssh_user = var.ssh_user
  ssh_public_key = var.ssh_public_key
  vpc_network = module.vpc-1.network_name
  vpc_subnetwork = element(module.vpc-1.subnet_name,1) # subnet_name, 1 because 1 means subnet-2 and 0 means subnet-1
}