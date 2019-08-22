data "aws_region" "current" {}

resource "aws_cloudwatch_log_group" "task_log" {
  name = "/ecs/osm-tile"
  retention_in_days = 1
}

# Log driver : https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_awslogs.html

# See : https://www.terraform.io/docs/providers/aws/d/iam_policy_document.html
data "aws_iam_policy_document" "task_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "task_role" {
  name = "osm-tile-ecs-task-role"
  assume_role_policy = "${data.aws_iam_policy_document.task_role_policy.json}"
}
resource "aws_iam_role_policy_attachment" "task_attach" {
  role = "${aws_iam_role.task_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# See : https://www.terraform.io/docs/providers/template/d/file.html
data "template_file" "task_definition_server" {
  template = "${file("${path.module}/task-templates/tile-server.json")}"

  vars = {
    log_group = "${aws_cloudwatch_log_group.task_log.name}"
    region = "${data.aws_region.current.name}"
    db_host = var.db_instance_address
    db_map_db = "${var.db_map_db}"
    db_map_user = "${var.db_map_user}"
    db_map_password = "${var.db_map_password}"
  }
}

# AWS ECS task definitions
# https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
resource "aws_ecs_task_definition" "server" {
  # A unique name for task definition.
  family = "osm-tile"
  requires_compatibilities = ["EC2"]
  execution_role_arn = "${aws_iam_role.task_role.arn}"
  container_definitions = "${data.template_file.task_definition_server.rendered}"
  network_mode = "awsvpc"

  volume {
    name = "tiles"
  }
  volume {
    name = "var-run-renderd"
  }

  # ログ設定
  # ログドライバー:: awslogs
  # キー	値
  # awslogs-group	/ecs/wdip-demo
  # awslogs-region	us-east-1
  # awslogs-stream-prefix	ecs
}

data "template_file" "task_definition_util" {
  template = "${file("${path.module}/task-templates/tile-util.json")}"

  vars = {
    log_group = "${aws_cloudwatch_log_group.task_log.name}"
    region = "${data.aws_region.current.name}"
    db_host = var.db_instance_address
    db_admin_user = "${var.db_admin_user}"
    db_admin_password = "${var.db_admin_password}"
    db_map_db = "${var.db_map_db}"
    db_map_user = "${var.db_map_user}"
    db_map_password = "${var.db_map_password}"
  }
}

# AWS ECS task definitions
# https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
resource "aws_ecs_task_definition" "util" {
  # A unique name for task definition.
  family = "osm-tile-util"
  requires_compatibilities = ["EC2"]
  execution_role_arn = "${aws_iam_role.task_role.arn}"
  container_definitions = "${data.template_file.task_definition_util.rendered}"
  network_mode = "host"

  volume {
    name = "map_data"
    host_path = "/var/map_data"
  }
}
