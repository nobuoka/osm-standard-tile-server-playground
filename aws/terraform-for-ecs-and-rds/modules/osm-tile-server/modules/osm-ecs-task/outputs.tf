output "ecs_task_definition_server" {
  value = aws_ecs_task_definition.server[0]
}

output "ecs_task_definition_prerenderer" {
  value = aws_ecs_task_definition.prerenderer[0]
}

output "ecs_task_definition_util" {
  value = aws_ecs_task_definition.util[0]
}
