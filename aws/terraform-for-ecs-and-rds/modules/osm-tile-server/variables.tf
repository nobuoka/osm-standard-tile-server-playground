variable "enabled" {
  type = bool
  default = true
}
variable "env_name" {
  type = string
  default = ""
}

variable "vpc_id" {
  type = string
}
variable "loadbalancer_target_group_arn" {
  type = string
}
variable "ecs_cluster" {
  // aws_ecs_cluster resource ( https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html )
  type = object({
    id = string
    name = string
  })
}
variable "default_sg_id" {
  type = string
}
variable "public_subnet_ids" {
  type = list(string)
}
variable "db_subnet_ids" {
  type = list(string)
}
variable "db_availability_zone" {
  type = string
}
variable "db_admin_user" {
  type = string
}
variable "db_admin_password" {
  type = string
}
variable "db_map_db" {
  type = string
}
variable "db_map_user" {
  type = string
}
variable "db_map_password" {
  type = string
}
