variable "aws_configure_profile" {}
variable "aws_region" { default = "ap-northeast-1" }
variable "db_admin_user" { default = "super" }
variable "db_admin_password" {}
variable "db_map_user" { default = "map" }
variable "db_map_password" {}
variable "db_map_db" { default = "map" }

provider "aws" {
  version = "~> 2.11.0"
  profile = "${var.aws_configure_profile}"
  region = "${var.aws_region}"
}
provider "template" {
  version = "~> 2.1.2"
}

module "vpc" {
  source = "./modules/vpc"
}
