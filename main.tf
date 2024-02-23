# Terraform Main File
terraform {
  cloud {
    organization = "geekat7"

    workspaces {
      name = "InfraProject"
    }
  }
}

variable "region_main" {
  default = "us-east-1"
}

provider "aws" {
  profile = "default"
  region  = var.region_main
}

module "Networking" {
  source = "./module/Networking"
  region = var.region_main
}

module "Compute" {
  source = "./module/Compute"
  region = var.region_main
  vpc_id_main = module.Networking.main_vpc_id
  publicsub1 = module.Networking.public_subnet_1
  publicsub2 = module.Networking.public_subnet_2
  albsg = module.Networking.external_sg_id
  ec2sg = module.Networking.internal_sg_id
}