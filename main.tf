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
} 
