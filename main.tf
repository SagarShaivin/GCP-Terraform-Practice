# GCP Provider

provider "google" {
  credentials = file(var.triage_1_terraform_key)
  project = var.gcp_project_id
}

# This module will create a vpc named (vpc-1)
module "vpc-1" {
  source = "./modules/VPC"
  vpc_name = "vpc-1"
}

module "subnet-1" {
  source = "./modules/Subnets"
  subnet_iprange = "10.0.1.0/24"
  subnet_name = "public-subnet"
  region_name = "us-central1"
  vpc_name = module.vpc-1.vpc_name
}

module "subnet-2" {
  source = "./modules/Subnets"
  subnet_iprange = "10.0.2.0/24"
  subnet_name = "private-subnet"
  region_name = "us-central1"
  vpc_name = module.vpc-1.vpc_name
}

module "static-ip-1" {
  source = "./modules/Static-IP"
  static_ipname = "static-ip-bastion"
  region_name = "us-central1"
}

# This module will help to create custom firewall rule, we can create multiple modules if we need 
module "firewall-1" {
  source = "./modules/Firewall"

  firewall_name = "ssh-to-bastion"
  target_vpc = module.vpc-1.vpc_name
  protocol_type = "tcp"
  allowed_ports = ["22"]
  allowed_iprange = ["0.0.0.0/0"]
  target_instances = ["tag-1"]
}

module "firewall-2" {
  source = "./modules/Firewall"

  firewall_name = "ssh-bastion-to-private"
  target_vpc = module.vpc-1.vpc_name
  protocol_type = "tcp"
  allowed_ports = ["22"]
  allowed_iprange = ["10.0.1.0/24"]
  target_instances = ["tag-2"]
}

module "firewall-3" {
  source = "./modules/Firewall"

  firewall_name = "custom-ports-bastion"
  target_vpc = module.vpc-1.vpc_name
  protocol_type = "tcp"
  allowed_ports = ["22", "2222"]
  allowed_iprange = ["0.0.0.0/0"]
  target_instances = ["tag-1"]
}


module "firewall-4" {
  source = "./modules/Firewall"

  firewall_name = "laravel-app"
  target_vpc = module.vpc-1.vpc_name
  protocol_type = "tcp"
  allowed_ports = ["8000"]
  allowed_iprange = ["10.0.1.0/24"]
  target_instances = ["tag-2"]
}

module "NAT-1" {
  source = "./modules/NAT"
  router_name = "nat-router-1"
  vpc_name = module.vpc-1.vpc_name
  region_name = "us-central1"
  private_subnet-name = module.subnet-2.subnet_name

}

# This module will create instances as per our requirement but make sure you provide proper zone,
# because the zone you will use to create the instance, then you will need to assign the instance to subnet which is also created in the same zone.
module "gce-1" {
  source = "./modules/Compute Engine"
  inst_name = "bastion-host"
  inst_type = "e2-micro"
  zone_name = "us-central1-a"
  image_type = "ubuntu-os-cloud/ubuntu-2204-lts"
  tags = ["tag-1"]
  static_ip = module.static-ip-1.static_ip
  ssh_user = var.ssh_user
  ssh_public_key = var.ssh_public_key
  vpc_network = module.vpc-1.vpc_name
  vpc_subnetwork = module.subnet-1.subnet_name
  assign_public_ip = true #Assign public IP to the bastion host
}

module "gce-2" {
  source = "./modules/Compute Engine"
  inst_name = "app-laravel"
  inst_type = "e2-medium"
  zone_name = "us-central1-a"
  image_type = "ubuntu-os-cloud/ubuntu-2204-lts"
  tags = ["tag-2"]
  static_ip = ""
  ssh_user = var.ssh_user
  ssh_public_key = var.ssh_public_key
  vpc_network = module.vpc-1.vpc_name
  vpc_subnetwork = module.subnet-2.subnet_name
  assign_public_ip = false
}
