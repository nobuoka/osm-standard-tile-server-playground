resource "aws_security_group" "db" {
    name = "db_server"
    vpc_id = "${aws_vpc.main.id}"
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
    subnet_ids  = ["${aws_subnet.private_db1.id}", "${aws_subnet.private_db2.id}"]
}

resource "aws_db_instance" "db" {
    identifier = "dbinstance"
    allocated_storage = 5
    engine = "postgres"
    engine_version = "11.2"
    instance_class = "db.t2.micro"
    storage_type = "gp2"
    username = "${var.db_user}"
    password = "${var.db_password}"
    publicly_accessible = true
    backup_retention_period = 1
    vpc_security_group_ids = ["${aws_security_group.db.id}"]
    db_subnet_group_name = "${aws_db_subnet_group.main.name}"
}
