# Terraform doesnt support interpolation in config blocks, so just hardcode it folks

terraform {
  backend "s3" {
    bucket               = "awesome-store"
    key                  = "project.tfstate"
    workspace_key_prefix = "environments"
    region               = "us-west-2"
  }
}
