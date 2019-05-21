variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "aws_az_db1" {}
variable "aws_az_db2" {}
variable "db_user" {}
variable "db_password" {}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default = "10.0.0.0/24"
}
variable "private_db1_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = "10.0.11.0/24"
}
variable "private_db2_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = "10.0.12.0/24"
}

provider "aws" {
  version = "~> 2.11.0"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}
provider "template" {
  version = "~> 1.0"
}
