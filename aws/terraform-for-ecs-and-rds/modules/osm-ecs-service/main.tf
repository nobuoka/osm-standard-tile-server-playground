resource "aws_ecs_cluster" "main" {
  name = "osm-tile"
}

resource "aws_ecs_service" "server" {
  name = "osm-tile-server"
  cluster = "${aws_ecs_cluster.main.id}"
  task_definition = var.ecs_task_definition_server_arn
  desired_count = 0
  launch_type = "FARGATE"

  network_configuration {
    subnets = var.public_subnet_ids
    security_groups = [var.default_sg_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name = "apache"
    container_port = 80
  }

  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = ["desired_count"]
  }
}
