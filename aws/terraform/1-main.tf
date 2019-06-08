variable "aws_configure_profile" {}
variable "aws_region" { default = "ap-northeast-1" }
variable "db_admin_user" { default = "super" }
variable "db_admin_password" {}
variable "db_map_user" { default = "map" }
variable "db_map_password" {}
variable "db_map_db" { default = "map" }

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
  profile = "${var.aws_configure_profile}"
  region = "${var.aws_region}"
}
provider "template" {
  version = "~> 1.0"
}
