variable "vpc_azs" {
  type = list
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vpc_private_subnets" {
  type = list
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnets" {
  type = list
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "enable_nat_gateway" {
  default = false
}

variable "resources_prefix" {
  default = "resources"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "public_ip" {
}

variable "project_name" {
}

variable "public_key_name" {
  description = "ssh pub key name"
  type        = string
}


variable "asg_min_size" {
  default = "2"
}

variable "asg_max_size" {
  default = "6"
}

variable "asg_def_size" {
  default = "3"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "file_name" {

}