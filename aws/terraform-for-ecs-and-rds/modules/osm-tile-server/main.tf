module "db" {
  source = "./modules/database"

  vpc_id = var.vpc_id
  db_subnet_ids = var.db_subnet_ids
  db_availability_zone = var.db_availability_zone
  db_admin_user = var.db_admin_user
  db_admin_password = var.db_admin_password
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

  vpc_id = var.vpc_id
  public_subnet_ids = var.public_subnet_ids
  target_group_arn = var.loadbalancer_target_group_arn
  ecs_task_definition_server_arn = module.ecs_task.ecs_task_definition_server.arn
  default_sg_id = var.default_sg_id
}
