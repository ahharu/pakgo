module "vpc" {

  version = "~> 2.24.0"
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project_name}-${terraform.workspace}-vpc"
  cidr = "${var.vpc_cidr}"

  azs             = "${var.vpc_azs}"
  private_subnets = "${var.vpc_private_subnets}"
  public_subnets  = "${var.vpc_public_subnets}"

  enable_nat_gateway = "${var.enable_nat_gateway}"

  default_vpc_enable_dns_hostnames = true
  default_vpc_enable_dns_support = true
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Environment = "${terraform.workspace}"
  }


}