variable "vpc_cidr" {
  type = string
  description = "CIDR for the whole VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type = string
  description = "CIDR for the Public Subnet"
  default = "10.0.0.0/24"
}

variable "private_db1_subnet_cidr" {
  type = string
  description = "CIDR for the Private Subnet"
  default = "10.0.11.0/24"
}

variable "private_db2_subnet_cidr" {
  type = string
  description = "CIDR for the Private Subnet"
  default = "10.0.12.0/24"
}
