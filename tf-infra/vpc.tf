module "vpc" {
  source = "./modules/vpc"

  project_name        = "${var.project_name}"
  vpc_azs             = "${var.vpc_azs}"
  vpc_private_subnets = "${var.vpc_private_subnets}"
  vpc_public_subnets  = "${var.vpc_public_subnets}"

  enable_nat_gateway = "${var.enable_nat_gateway}"
}