output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "db_subnet_ids" {
  value = ["${aws_subnet.private_db1.id}", "${aws_subnet.private_db2.id}"]
}
