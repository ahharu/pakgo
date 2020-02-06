module "asg" {
  source = "./modules/asg"

  project_name        = "${var.project_name}"
  public_key_name     = "${var.public_key_name}"
  ami_base_name       = "${var.project_name}-${terraform.workspace}"
  autoscaling_enabled = true
  min_size            = "${var.asg_min_size}"
  max_size            = "${var.asg_max_size}"
  def_size            = "${var.asg_def_size}"
  vpc_id              = "${module.vpc.id}"
  vpc_subnets         = "${module.vpc.public_subnets}"
  public_ip           = "${var.public_ip}"
  instance_type       = "${var.instance_type}"
  file_name           = "${var.file_name}"
}