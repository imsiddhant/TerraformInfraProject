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

module "Database" {
  source      = "./module/Database"
  region      = var.region_main
  vpc_id_main = module.Networking.main_vpc_id
  ec2sg       = module.Networking.internal_sg_id
  privatesub1 = module.Networking.private_subnet_1
  privatesub2 = module.Networking.private_subnet_2
}

module "Compute" {
  source            = "./module/Compute"
  region            = var.region_main
  vpc_id_main       = module.Networking.main_vpc_id
  publicsub1        = module.Networking.public_subnet_1
  publicsub2        = module.Networking.public_subnet_2
  albsg             = module.Networking.external_sg_id
  ec2sg             = module.Networking.internal_sg_id
  DB_USER           = module.Database.Username
  DB_PASSWORD_PARAM = module.Database.Password
  DB_HOST           = module.Database.Host
  DB_NAME           = module.Database.dbname
  DB_PORT           = module.Database.Port
}

module "Monitoring" {
  source      = "./module/Monitoring"
  region      = var.region_main
  asg_name    = module.Compute.ASG_Name
  db_identity = module.Database.Identifier
}