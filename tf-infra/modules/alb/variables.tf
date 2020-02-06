variable "resource_prefix" {}
variable "kubernetes_node_cluseter_name" {}
variable "networking_state_bucket" {}
variable "networking_state_key" {}
variable "route53_domain_name" {}
variable "cluster_name" {}
variable "alb_idle_timeout" {}
variable "alb_target_group_healthcheck_interval" {}
variable "alb_target_group_healthcheck_path" {}
variable "alb_target_group_healthcheck_protocol" {}
variable "alb_target_group_healthcheck_timeout" {}
variable "alb_target_group_healthcheck_healthy_threshold" {}
variable "alb_target_group_healthcheck_unhealthy_threshold" {}
variable "alb_target_group_healthcheck_matcher" {}
variable "alb_ingress_cidr" {}
variable "target_group_names" {
  type = "list"
}
variable "target_group_http_ports" {
  type = "list"
}
variable "target_group_https_ports" {
  type = "list"
}
variable "target_group_healthcheck_http_ports" {
  type = "list"
}
variable "listener_rule_http_priorities" {
  type = "list"
}
variable "listener_rule_https_priorities" {
  type = "list"
}

variable "listener_rule_path_patterns" {
  type = "list"
}
variable "enabled" {}

