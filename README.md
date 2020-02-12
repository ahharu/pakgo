# What is Pakgo ?

It is a docker self-contained project to deploy go-based apps to aws on ASG


# What do I need on my computer? 

Docker!!

Your credentials setup in `~/.aws/credentials` ( when you configure awscli you should have them here )

# How to use ..

`make deploy`

You can configure some options DIRECTLY from the make call, by setting up environment variables like this

`PROJECT_NAME=pakgo make deploy`

These are the variables:

- REGION : Specify the region in which to deploy the infra
- PACKER_NAME : specify which is the json file to use for packer base image
- PROJECT_NAME : The name of the project! This is important as well to get the vars
- SSH_KEY : Which SSH key to use to connect to EC2 machines ( put the pub file in the public_files directory )
- STATE : Whether PRESENT or ABSENT
- ENVIRONMENT : Environment ( for naming purposes )
- FILE_NAME : This is the path to your compiled go app.

## Tfvars configurable parameters

You can create tfvars/<project_name>.tf file if you want to configure more infrastructure variables.

The variables available are..

| Name                                             | Description                                         | Type                     | Default                                             | Required |
|--------------------------------------------------|-----------------------------------------------------|--------------------------|-----------------------------------------------------|----------|
| vpc_azs                                          | Which AZs in to create VPC/Subnets                  | List                     | ["us-west-2a", "us-west-2b", "us-west-2c"]          | Yes      |
| vpc_private_subnets                              | Private Subnet CIDRs to create                      | List                     | ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]       | Yes      |
| vpc_public_subnets                               | Public Subnet CIDRs to create                       | List                     | ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"] | Yes      |
| enable_nat_gateway                               | Want to deploy NAT gateway?                         | Boolean                  | false                                               | Yes      |
| vpc_cidr                                         | VPC CIDR to create                                  | String                   | 10.0.0.0/16                                         | Yes      |
| aws_region                                       | AWS Region to use                                   | String                   | us-west-2                                           | Yes      |
| public_ip                                        | IP where the terraform is being run, for EC2 access | String                   | OWN IP                                              | Yes      |
| project_name                                     | Name of the project                                 | String                   |                                                     | Yes      |
| public_key_name                                  | Name of ssh key                                     | String                   |                                                     | Yes      |
| asg_min_size                                     | Minimum ASG size                                    | String                   | 2                                                   | Yes      |
| asg_max_size                                     | Maximum ASG size                                    | String                   | 6                                                   | No       |
| asg_def_size                                     | Desired ASG size                                    | String                   | 3                                                   | No       |
| instance_type                                    | Instance Type to Use                                | String                   | t3.medium                                           | No       |
| alb_target_group_healthcheck_interval            | How often to check healthcheck ( in seconds )       | String                   | 5                                                   | No       |
| alb_target_group_healthcheck_path                | Path for healthcheck                                | String                   | /health                                             | No       |
| alb_target_group_healthcheck_timeout             | Healthcheck request timeout                         | String                   | 5                                                   | No       |
| alb_target_group_healthcheck_healthy_threshold   | How many healthy checks to mark as healthy          | String                   | 5                                                   | No       |
| alb_target_group_healthcheck_unhealthy_threshold | How many healthy checks to mark as unhealthy        | String                   | 2                                                   | No       |
| alb_http_target_group_port                       | Target group port                                   | List                     | []                                                  | No       |
| alb_http_target_group_healthcheck_port           | Healthcheck port                                    | String                   | 80                                                  | No       |
| alb_idle_timeout                                 | Connection Idle timeout                             | String                   | 300                                                 | No       |
| alb_ingress_cidr                                 | CIDR to allow access to ALB                         | String                   | 0.0.0.0/0                                           | No       |
| alb_target_group_healthcheck_protocol            | Healthcheck protocol                                | String                   | HTTP                                                | No       |
| alb_target_group_healthcheck_matcher             | Response codes to treat as healthy                  | String (comma separated) | 200                                                 | No       |
| ssh_allowed_cidrs                                | Extra cidrs to allow SSH                            | List                     | []                                                  | No       |
