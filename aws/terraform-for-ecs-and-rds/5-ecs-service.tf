resource "aws_ecs_cluster" "main" {
  name = "osm-tile"
}

resource "aws_security_group" "server_task" {
  name        = "osm-tile-server"
  description = "Allow tcp 80 inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "server" {
  name = "osm-tile-server"
  cluster = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.server.arn}"
  desired_count = 0
  launch_type = "FARGATE"

  network_configuration {
    subnets = module.vpc.public_subnet_ids
    security_groups = [
      "${aws_security_group.server_task.id}"
    ]
    assign_public_ip = true
  }

  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = ["desired_count"]
  }
}
