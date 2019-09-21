variable "vpc_id" {
    type = string
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
