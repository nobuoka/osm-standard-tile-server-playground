variable "enabled" {
  type = bool
  default = true
}
variable "resource_name_prefix" {
  type = string
  default = ""
}

variable "vpc_id" {
  type = string
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

variable "db_allocated_storage_in_gb" {
  type = number
}
