output "public_subnet_ids" {
  value = [module.vpc.public_subnet_ids[0]]
}

output "default_sg_id" {
  value = module.vpc.default_sg.id
}

output "lb_dns_name" {
  value = module.loadbalancer.loadbalancer.dns_name
}
output "staging_lb_dns_name" {
  value = module.loadbalancer.loadbalancer_staging.dns_name
}

output "main_cluster_name" {
  value = module.osm_tile_server_main.cluster_name
}
output "main_task_definition_util" {
  value = module.osm_tile_server_main.ecs_task_definition_util.family
}
output "main_task_definition_prerenderer" {
  value = module.osm_tile_server_main.ecs_task_definition_prerenderer.family
}

output "backup_cluster_name" {
  value = module.osm_tile_server_backup.cluster_name
}
output "backup_task_definition_util" {
  value = module.osm_tile_server_backup.ecs_task_definition_util.family
}
output "backup_task_definition_prerenderer" {
  value = module.osm_tile_server_backup.ecs_task_definition_prerenderer.family
}
