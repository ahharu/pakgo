# Security Group for EC2 instance
resource "aws_security_group" "sg" {
  name   = "${var.project_name}-${terraform.workspace}-ec2-sg"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol    = "tcp"
    cidr_blocks =  "${concat(var.ssh_allowed_cidrs, local.public_ip)}"
    from_port   = "22"
    to_port     = "22"
  }

  ingress {
    protocol        = "tcp"
    from_port       = "80"
    to_port         = "80"
    security_groups = ["${aws_security_group.sg_alb.id}"]
  }

  ingress {
    protocol        = "tcp"
    from_port       = "443"
    to_port         = "443"
    security_groups = ["${aws_security_group.sg_alb.id}"]
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }


}

# Security Group for ALB
resource "aws_security_group" "sg_alb" {
  name   = "${var.project_name}-${terraform.workspace}-alb-sg"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    to_port     = "80"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "443"
    to_port     = "443"
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }

}