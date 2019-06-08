data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "osm-tile-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_subnet" "private_db1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_db1_subnet_cidr}"
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
    tags {
        Name = "Private Subnet for osm-tile"
    }
}
resource "aws_subnet" "private_db2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_db2_subnet_cidr}"
    availability_zone = "${data.aws_availability_zones.available.names[1]}"
    tags {
        Name = "Private Subnet for osm-tile"
    }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.public_subnet_cidr}"
  #availability_zone = "eu-west-1a"
  tags {
    Name = "Public Subnet for osm-tile"
  }
}
resource "aws_route_table" "public_subnet" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
  tags {
    Name = "Public Subnet for osm-tile"
  }
}
resource "aws_route_table_association" "public_subnet" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_subnet.id}"
}
