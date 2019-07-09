variable "vpc_id" {
  type = string
}

variable "db_subnet_ids" {
  type = list(string)
}

variable "db_admin_user" {
  type = string
}

variable "db_admin_password" {
  type = string
}
