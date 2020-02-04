output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "vpc_arn" {
  value = "${module.vpc.arn}"
}

output "vpc_id" {
  value = "${module.vpc.id}"
}

