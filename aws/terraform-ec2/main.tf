terraform {
  required_version = ">= 0.12.0"
}

variable "aws_region" { default = "ap-northeast-1" }

provider "aws" {
  version = "~> 2.27.0"
  region = "${var.aws_region}"
}

module "vpc" {
  source = "./modules/vpc"
}
