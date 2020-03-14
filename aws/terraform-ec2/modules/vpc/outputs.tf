output "vpc_id" {
  value = aws_vpc.main.id
}

output "default_sg" {
  value = aws_default_security_group.default
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}
