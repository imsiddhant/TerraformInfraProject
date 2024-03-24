# This file stores the Variables for Compute Module

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

variable "publicsub1" {
  type    = string
  default = "example_pubsub_1"
}

variable "publicsub2" {
  type    = string
  default = "example_pubsub_2"
}

variable "albsg" {
  type    = string
  default = "example_albsg"
}

variable "ec2sg" {
  type    = string
  default = "example_ec2sg"
}

variable "DB_HOST" {
  type    = string
  default = "hostname"
}

variable "DB_NAME" {
  type    = string
  default = "name"
}

variable "DB_PASSWORD_PARAM" {
  type    = string
  default = "password"
}

variable "DB_PORT" {
  type    = string
  default = "port"
}

variable "DB_USER" {
  type    = string
  default = "username"
}