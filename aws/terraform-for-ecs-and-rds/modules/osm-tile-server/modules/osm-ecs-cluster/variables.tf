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

variable "ecs_cluster" {
  // aws_ecs_cluster resource ( https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html )
  type = object({
    id = string
    name = string
  })
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "target_group_arn" {
    type = string
}

variable "ecs_task_definition_server_arn" {
    type = string
}

variable "default_sg_id" {
    type = string
}
