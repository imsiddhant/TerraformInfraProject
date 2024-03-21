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

variable "privatesub" {
  type    = string
  default = "private_subnet"
}