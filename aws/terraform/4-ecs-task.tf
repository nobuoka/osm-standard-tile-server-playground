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
data "template_file" "task_definition" {
  template = "${file("2-ecs-task/tile-server.json")}"

  vars {
    log_group = "${aws_cloudwatch_log_group.task_log.name}"
    region = "${var.aws_region}"
    db_host = "${aws_db_instance.db.address}"
    db_user = "${var.db_user}"
    db_password = "${var.db_password}"
  }
}

# AWS ECS task definitions
# https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
resource "aws_ecs_task_definition" "server" {
  # A unique name for task definition.
  family = "osm-tile"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = "${aws_iam_role.task_role.arn}"
  container_definitions = "${data.template_file.task_definition.rendered}"
  network_mode = "awsvpc"
  cpu = "256"
  memory = "512"

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
