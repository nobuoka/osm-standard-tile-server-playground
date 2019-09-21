variable "vpc_id" {
  type = string
}
variable "loadbalancer_target_group_arn" {
  type = string
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
