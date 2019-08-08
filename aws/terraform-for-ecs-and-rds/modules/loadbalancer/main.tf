resource "aws_security_group" "osm_tile_alb_sg" {
  name        = "osm-tile-alb"
  description = "Allow tcp 80 inbound traffic"
  vpc_id      = var.vpc_id

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

resource "aws_lb" "osm_tile_lb" {
    name = "osm-tile-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [
        aws_security_group.osm_tile_alb_sg.id,
        var.default_sg_id
    ]
    subnets = var.public_subnet_ids
}

resource "aws_lb_target_group" "osm_tile_lb_target_group" {
  name = "osm-tile-lb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "osm_tile_lb_listener" {
  load_balancer_arn = "${aws_lb.osm_tile_lb.arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.osm_tile_lb_target_group.arn}"
  }
}
