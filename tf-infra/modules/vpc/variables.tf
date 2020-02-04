

variable "vpc_azs" {
  type = "list"
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vpc_private_subnets" {
  type = "list"
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnets" {
  type = "list"
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "enable_nat_gateway" {
  default = false
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "project_name" {
}