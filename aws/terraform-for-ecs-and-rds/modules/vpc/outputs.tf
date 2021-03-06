output "vpc_id" {
  value = aws_vpc.main.id
}

output "default_sg" {
  value = aws_default_security_group.default
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "db_subnets" {
  value = [aws_subnet.private_db1, aws_subnet.private_db2]
}
