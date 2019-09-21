resource "aws_ecs_cluster" "main" {
  name = "osm-tile"
}

data "template_file" "ecs_container_instance_user_data" {
  template = "${file("${path.module}/ec2_user_data.template")}"

  vars = {
    cluster_name = "${aws_ecs_cluster.main.name}"
  }
}

data "aws_iam_instance_profile" "ecs_instance_profile" {
  # This IAM Role (and IAM Instance Profile) should be created manually.
  # https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/instance_IAM_role.html
  name = "ecsInstanceRole"
}

resource "aws_instance" "ecs_container_instance" {
  # For ap-northeast-1 region
  # See : https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/launch_container_instance.html
  ami = "ami-04a735b489d2a0320"
  instance_type = "t2.large"
  iam_instance_profile = data.aws_iam_instance_profile.ecs_instance_profile.name
  subnet_id = var.public_subnet_ids[0]
  associate_public_ip_address = true
  monitoring = true
  disable_api_termination = false
  user_data = data.template_file.ecs_container_instance_user_data.rendered
  tags = {
    Name = "ECS Container Instance"
  }
}

resource "aws_ecs_service" "server" {
  name = "osm-tile-server"
  cluster = "${aws_ecs_cluster.main.id}"
  task_definition = var.ecs_task_definition_server_arn
  desired_count = 0
  launch_type = "EC2"

  network_configuration {
    subnets = [var.public_subnet_ids[0]]
    security_groups = [var.default_sg_id]
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
