variable "enabled" {
  type = bool
  default = true
}
variable "resource_group_name" {
  type = string
  default = "osm-tile"
}

variable "db_instance_address" {
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
