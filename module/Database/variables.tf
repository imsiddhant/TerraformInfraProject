# This file stores the Variables for Database Module

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "tag_value" {
  type    = string
  default = "TerraformInfraProject"
}

variable "vpc_id_main" {
  type    = string
  default = "example_vpc_id"
}

variable "ec2sg" {
  type    = string
  default = "example_ec2sg"
}

variable "privatesub1" {
  type    = string
  default = "private_subnet"
}

variable "privatesub2" {
  type    = string
  default = "private_subnet"
}