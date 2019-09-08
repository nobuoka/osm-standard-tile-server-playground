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
provider "template" {
  version = "~> 2.1.2"
}

module "vpc" {
  source = "./modules/vpc"
}

module "db" {
  source = "./modules/database"

  vpc_id = module.vpc.vpc_id
  db_subnet_ids = module.vpc.db_subnets.*.id
  db_availability_zone = module.vpc.db_subnets[0].availability_zone
  db_admin_user = var.db_admin_user
  db_admin_password = var.db_admin_password
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  default_sg_id = module.vpc.default_sg.id
}

module "ecs_task" {
  source = "./modules/osm-ecs-task"

  db_instance_address = module.db.db_instance.address
  db_admin_user = var.db_admin_user
  db_admin_password = var.db_admin_password
  db_map_db = var.db_map_db
  db_map_user = var.db_map_user
  db_map_password = var.db_map_password
}

module "ecs_cluster" {
  source = "./modules/osm-ecs-cluster"

  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  target_group_arn = module.loadbalancer.osm_tile_target_group.arn
  ecs_task_definition_server_arn = module.ecs_task.ecs_task_definition_server.arn
  default_sg_id = module.vpc.default_sg.id
}
