variable "resource_prefix" {}
variable "alb_idle_timeout" {}
variable "alb_target_group_healthcheck_interval" {}
variable "alb_target_group_healthcheck_path" {}
variable "alb_target_group_healthcheck_protocol" {}
variable "alb_target_group_healthcheck_timeout" {}
variable "alb_target_group_healthcheck_healthy_threshold" {}
variable "alb_target_group_healthcheck_unhealthy_threshold" {}
variable "alb_target_group_healthcheck_matcher" {}
variable "alb_ingress_cidr" {}
variable "vpc_id" {}
variable "vpc_subnets" {
  type = "list"
}

variable "asg_sg_id" {}
variable "asg_name" {}
variable "target_group_names" {
  type = "list"
}
variable "target_group_http_ports" {
  type = "list"
}
variable "target_group_healthcheck_http_ports" {
  type = "list"
}
variable "listener_rule_http_priorities" {
  type = "list"
}

variable "listener_rule_path_patterns" {
  type = "list"
}
variable "enabled" {}

