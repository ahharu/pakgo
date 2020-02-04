output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "arn" {
  value = "${module.vpc.vpc_arn}"
}

output "id" {
  value = "${module.vpc.vpc_id}"
}