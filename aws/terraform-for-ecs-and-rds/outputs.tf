output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "default_sg_id" {
  value = module.vpc.default_sg.id
}

output "lb_dns_name" {
  value = module.loadbalancer.loadbalancer.dns_name
}
