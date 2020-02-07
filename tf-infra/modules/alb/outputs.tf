output "http_ports" {
  value = "${aws_lb_target_group.http.*.port}"
}

output "dns_name" {
  value = "${aws_lb.alb.*.dns_name}"
}