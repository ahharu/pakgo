locals {
  project_sh      = "${file("${path.module}/config/project.sh")}"
  project_service = "${templatefile("${path.module}/config/project.service" , { project_name = var.project_name })}"
  public_ip            = ["${var.public_ip}/32"]
  public_key_file_name = "/app/public_keys/${var.public_key_name}"
  public_key_file      = "${file(local.public_key_file_name)}"
  project_name         = "${var.project_name}"

}