output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "default_sg_id" {
  value = module.vpc.default_sg.id
}
