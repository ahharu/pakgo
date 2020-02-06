resource "aws_lb" "alb" {
  count              = "${var.enabled ? 1 : 0}"
  name               = "${var.resource_prefix}alb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  idle_timeout       = "${var.alb_idle_timeout}"
  security_groups    = ["${aws_security_group.alb.id}"]
  subnets            = ["${data.aws_subnet_ids.kubernetes.ids}"]

  tags {
    Name        = "${var.resource_prefix}alb"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_security_group" "alb" {
  count       = "${var.enabled ? 1 : 0}"
  name        = "${var.resource_prefix}alb"
  description = "${var.resource_prefix}alb"
  vpc_id      = "${data.aws_vpc.kubernetes.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${split(",",var.alb_ingress_cidr)}"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${split(",",var.alb_ingress_cidr)}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.resource_prefix}alb"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_lb_target_group" "http" {
  count       = "${var.enabled ? length(var.target_group_names) : 0}"
  name        = "${var.resource_prefix}http-${var.target_group_names[count.index]}"
  port        = "${var.target_group_http_ports[count.index]}"
  protocol    = "HTTP"
  vpc_id      = "${data.aws_vpc.kubernetes.id}"
  target_type = "instance"

  health_check {
    interval            = "${var.alb_target_group_healthcheck_interval}"
    path                = "${var.alb_target_group_healthcheck_path}"
    port                = "${var.target_group_healthcheck_http_ports[count.index]}"
    protocol            = "${var.alb_target_group_healthcheck_protocol}"
    timeout             = "${var.alb_target_group_healthcheck_timeout}"
    healthy_threshold   = "${var.alb_target_group_healthcheck_healthy_threshold}"
    unhealthy_threshold = "${var.alb_target_group_healthcheck_unhealthy_threshold}"
    matcher             = "${var.alb_target_group_healthcheck_matcher}"
  }

  tags {
    Name        = "${var.resource_prefix}${var.target_group_names[count.index]}" # https
    Cluster     = "${var.cluster_name}"
    Environment = "${terraform.workspace}"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_attachment" "nodes_http" {
  count                  = "${var.enabled ? length(var.target_group_names) : 0}"
  alb_target_group_arn   = "${aws_lb_target_group.http.*.arn[count.index]}"
  autoscaling_group_name = "${data.aws_autoscaling_groups.nodes.names[0]}"
}


resource "aws_alb_listener" "listener_http" {
  count             = "${var.enabled ? 1 : 0}"
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.http.*.arn[0]}"
    type             = "forward"
  }
}


resource "aws_lb_listener_rule" "forward_http" {
  count         = "${var.enabled ? length(var.target_group_names) - 1 : 0}"
  listener_arn  = "${aws_alb_listener.listener_http.arn}"
  priority      = "${var.listener_rule_http_priorities[count.index + 1]}"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.http.*.arn[count.index + 1]}"
  }

  condition {
    field  = "path-pattern"
    values = ["${var.listener_rule_path_patterns[count.index + 1]}"]
  }
}
