# This file stores the Variables for Database Module

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "tag_value" {
  type    = string
  default = "TerraformInfraProject"
}

variable "ec2sg" {
  type    = string
  default = "example_ec2sg"
}

variable "privatesub" {
  type    = string
  default = "private_subnet"
}