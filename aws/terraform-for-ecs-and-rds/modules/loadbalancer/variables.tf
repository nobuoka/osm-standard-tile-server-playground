variable "vpc_id" {
  type = string
}

variable "staging_elb_enabled" {
  type = bool
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "default_sg_id" {
    type = string
}
