data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags = {
    Name = "osm-tile-vpc"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.main.id}"

  # Default ingress
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  # Default egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_subnet" "private_db1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_db1_subnet_cidr}"
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
    tags = {
        Name = "Private Subnet for osm-tile"
    }
}
resource "aws_subnet" "private_db2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_db2_subnet_cidr}"
    availability_zone = "${data.aws_availability_zones.available.names[1]}"
    tags = {
        Name = "Private Subnet for osm-tile"
    }
}

resource "aws_subnet" "public_subnet" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = cidrsubnet(var.public_subnet_cidr, 4, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "Public Subnet for osm-tile"
  }
}
resource "aws_route_table" "public_subnet" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
  tags = {
    Name = "Public Subnet for osm-tile"
  }
}
resource "aws_route_table_association" "public_subnet" {
  count = length(data.aws_availability_zones.available.names)
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.public_subnet.*.id, count.index)
}
