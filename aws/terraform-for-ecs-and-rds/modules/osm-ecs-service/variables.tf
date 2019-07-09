variable "vpc_id" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "ecs_task_definition_server_arn" {
    type = string
}
