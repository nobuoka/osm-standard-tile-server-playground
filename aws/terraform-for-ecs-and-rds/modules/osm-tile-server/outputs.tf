output "cluster_name" {
  value = module.ecs_cluster.cluster_name
}

output "ecs_task_definition_server" {
  value = module.ecs_task.ecs_task_definition_server
}

output "ecs_task_definition_prerenderer" {
  value = module.ecs_task.ecs_task_definition_prerenderer
}

output "ecs_task_definition_util" {
  value = module.ecs_task.ecs_task_definition_util
}
