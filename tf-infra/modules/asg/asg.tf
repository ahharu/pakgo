# Find machine image

data "aws_ami" "amibuilder-linux" {
  most_recent      = true

  filter {
    name   = "name"
    values = ["${var.ami_base_name}-*"]
  }

  owners     = ["self"]
}

resource "aws_key_pair" "ssh" {
  key_name   = "${var.project_name}-${terraform.workspace}-key"
  public_key = "${local.public_key_file}"
}

# Launch configuration
# Configures the machines that are deployed
#
resource "aws_launch_configuration" "launch_config" {
  name_prefix                 = "${var.project_name}-${terraform.workspace}-lc"
  image_id                    = "${data.aws_ami.amibuilder-linux.id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.iam-role-name != "" ? var.iam-role-name : ""}"
  key_name                    = "${aws_key_pair.ssh.key_name}"
  user_data                   = "${templatefile("${path.module}/config/userdata.sh", { project_sh = local.project_sh , project_name = local.project_name, project_service = local.project_service })}"
  associate_public_ip_address = "${var.instance-associate-public-ip == "true" ? true : false}"
  security_groups             = ["${aws_security_group.sg.id}"]
}

# AutoScaling Group
# Scale (up/down) the number of machines, based on some criteria
#
resource "aws_autoscaling_group" "default" {
  count                     = var.enabled ? 1 : 0
  name                      = "${var.project_name}-${terraform.workspace}-asg"
  min_size                  = "${var.min_size}"
  desired_capacity          = "${var.def_size}"
  max_size                  = "${var.max_size}"
  launch_configuration      = "${aws_launch_configuration.launch_config.name}"
  vpc_zone_identifier       = "${var.vpc_subnets}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "ELB"

  lifecycle {
    create_before_destroy = true
  }

}