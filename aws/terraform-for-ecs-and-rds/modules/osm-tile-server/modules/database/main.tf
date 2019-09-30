resource "aws_security_group" "db" {
    count = (var.enabled ? 1 : 0)

    name = "${var.resource_name_prefix}db_server"
    vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "db" {
    count = (var.enabled ? 1 : 0)

    type                     = "ingress"
    from_port                = 5432
    to_port                  = 5432
    protocol                 = "tcp"
    cidr_blocks              = ["0.0.0.0/0"]
    security_group_id        = "${aws_security_group.db[0].id}"
}

resource "aws_db_subnet_group" "main" {
    count = (var.enabled ? 1 : 0)

    name        = "${var.resource_name_prefix}db_subnet"
    description = "It is a DB subnet group."
    subnet_ids  = var.db_subnet_ids
}

resource "aws_db_instance" "db" {
    count = (var.enabled ? 1 : 0)

    identifier = "${var.resource_name_prefix}dbinstance"
    engine = "postgres"
    engine_version = "11.2"
    instance_class = "db.m4.large"
    storage_type = "gp2"
    allocated_storage = var.db_allocated_storage_in_gb
    max_allocated_storage = 1500
    username = "${var.db_admin_user}"
    password = "${var.db_admin_password}"
    publicly_accessible = false
    backup_retention_period = 1
    vpc_security_group_ids = ["${aws_security_group.db[0].id}"]
    db_subnet_group_name = "${aws_db_subnet_group.main[0].name}"
    availability_zone = var.db_availability_zone
    skip_final_snapshot = true
}
