output "alb_sg_id" {
  value = "${aws_security_group.sg_alb.id}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.default[0].name}"
}
