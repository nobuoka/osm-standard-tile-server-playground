resource "aws_security_group" "db" {
    name = "db_server"
    vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "db" {
    type                     = "ingress"
    from_port                = 5432
    to_port                  = 5432
    protocol                 = "tcp"
    cidr_blocks              = ["0.0.0.0/0"]
    security_group_id        = "${aws_security_group.db.id}"
}

resource "aws_db_subnet_group" "main" {
    name        = "db_subnet"
    description = "It is a DB subnet group."
    subnet_ids  = var.db_subnet_ids
}

resource "aws_db_instance" "db" {
    identifier = "dbinstance"
    allocated_storage = 20
    engine = "postgres"
    engine_version = "11.2"
    instance_class = "db.m4.large"
    storage_type = "gp2"
    username = "${var.db_admin_user}"
    password = "${var.db_admin_password}"
    publicly_accessible = false
    backup_retention_period = 1
    vpc_security_group_ids = ["${aws_security_group.db.id}"]
    db_subnet_group_name = "${aws_db_subnet_group.main.name}"
    skip_final_snapshot = true
}
