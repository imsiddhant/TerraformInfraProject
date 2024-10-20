# This file stores the Variables for Monitoring Module

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "tag_value" {
  type    = string
  default = "TerraformInfraProject"
}

variable "asg_name" {
  type = string
  default = "value"
}

variable "db_identity" {
  type = string
  default = "value"
}