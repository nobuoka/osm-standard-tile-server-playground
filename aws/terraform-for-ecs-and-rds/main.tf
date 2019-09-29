terraform {
  required_version = ">= 0.12.0"
}

variable "aws_configure_profile" {}
variable "aws_region" { default = "ap-northeast-1" }
variable "db_admin_user" { default = "super" }
variable "db_admin_password" {}
variable "db_map_user" { default = "map" }
variable "db_map_password" {}
variable "db_map_db" { default = "map" }

provider "aws" {
  version = "~> 2.27.0"
  profile = "${var.aws_configure_profile}"
  region = "${var.aws_region}"
}

module "vpc" {
  source = "./modules/vpc"
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  default_sg_id = module.vpc.default_sg.id
}

module "osm_tile_server" {
  source = "./modules/osm-tile-server"

  vpc_id = module.vpc.vpc_id
  loadbalancer_target_group_arn = module.loadbalancer.osm_tile_target_group.arn
  default_sg_id = module.vpc.default_sg.id
  public_subnet_ids = module.vpc.public_subnet_ids
  db_subnet_ids = module.vpc.db_subnets.*.id
  db_availability_zone = module.vpc.db_subnets[0].availability_zone
  db_admin_user = var.db_admin_user
  db_admin_password = var.db_admin_password
  db_map_db = var.db_map_db
  db_map_user = var.db_map_user
  db_map_password = var.db_map_password
}
