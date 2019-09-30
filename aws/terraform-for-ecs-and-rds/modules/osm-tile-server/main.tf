module "db" {
  source = "./modules/database"

  enabled = var.enabled
  resource_name_prefix = "${var.env_name != "" ? "osm-tile-${var.env_name}-" : ""}"

  vpc_id = var.vpc_id
  db_subnet_ids = var.db_subnet_ids
  db_availability_zone = var.db_availability_zone
  db_admin_user = var.db_admin_user
  db_admin_password = var.db_admin_password
  db_allocated_storage_in_gb = var.db_allocated_storage_in_gb
}

module "ecs_task" {
  source = "./modules/osm-ecs-task"

  enabled = var.enabled
  resource_group_name = "osm-tile${var.env_name != "" ? "-${var.env_name}" : ""}"

  db_instance_address = module.db.db_instance.address
  db_admin_user = var.db_admin_user
  db_admin_password = var.db_admin_password
  db_map_db = var.db_map_db
  db_map_user = var.db_map_user
  db_map_password = var.db_map_password
}

module "ecs_cluster" {
  source = "./modules/osm-ecs-cluster"

  enabled = var.enabled
  ecs_cluster_name = "osm-tile${var.env_name != "" ? "-${var.env_name}" : ""}"

  vpc_id = var.vpc_id
  public_subnet_ids = var.public_subnet_ids
  target_group_arn = var.loadbalancer_target_group_arn
  ecs_task_definition_server_arn = module.ecs_task.ecs_task_definition_server.arn
  default_sg_id = var.default_sg_id
}
