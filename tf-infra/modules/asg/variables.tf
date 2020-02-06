variable "project_name" {
  default     = "app"
  description = "Solution name, e.g. 'app' or 'cluster'"
}

variable "file_name" {
  description = "file to exec"
}

variable "vpc_subnets" {
  type        = list(string)
  description = "List of vpc subnets"
}

variable "autoscaling_enabled" {
  default     = true
  description = "Enable autoscaling"
}

variable "ami_base_name" {
  type        = string
  description = "AMI BASE NAME"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_ip" {
  type        = string
  description = "local ip for ssh access to ec2"
}

variable "ssh_allowed_cidrs" {
  type        = list
  description = "VPC ID"
  default     = []
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "enabled" {
  type        = bool
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
  default     = true
}

variable "image_id" {
  type        = string
  description = "The EC2 image ID to launch"
  default     = ""
}

variable "instance_type" {
  type        = string
  description = "Instance type to launch"
}

variable "iam_instance_profile_name" {
  type        = string
  description = "The IAM instance profile name to associate with launched instances"
  default     = ""
}

variable "key_name" {
  type        = string
  description = "The SSH key name that should be used for the instance"
  default     = ""
}

variable "security_group_ids" {
  description = "A list of associated security group IDs"
  type        = list(string)
  default     = []
}

variable "launch_template_version" {
  type        = string
  description = "Launch template version. Can be version number, `$Latest` or `$Default`"
  default     = "$Latest"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with an instance in a VPC"
  default     = false
}

variable "max_size" {
  type        = number
  description = "The maximum size of the autoscale group"
  default     = 6
}

variable "min_size" {
  type        = number
  default = 3
  description = "The minimum size of the autoscale group"
}

variable "def_size" {
  description = "The default/recommended size of the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "default_cooldown" {
  type        = number
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "health_check_grace_period" {
  type        = number
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}

variable "health_check_type" {
  type        = string
  description = "Controls how health checking is done. Valid values are `EC2` or `ELB`"
  default     = "EC2"
}

variable "force_delete" {
  type        = bool
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = false
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `Default`"
  type        = list(string)
  default     = ["Default"]
}

variable "suspended_processes" {
  type        = list(string)
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your autoscaling group from functioning properly."
  default     = []
}

variable "placement_group" {
  type        = string
  description = "The name of the placement group into which you'll launch your instances, if any"
  default     = ""
}


variable "wait_for_capacity_timeout" {
  type        = string
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior"
  default     = "10m"
}


variable "protect_from_scale_in" {
  type        = bool
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events"
  default     = false
}

variable "service_linked_role_arn" {
  type        = string
  description = "The ARN of the service-linked role that the ASG will use to call other AWS services"
  default     = ""
}

variable "autoscaling_policies_enabled" {
  type        = bool
  default     = true
  description = "Whether to create `aws_autoscaling_policy` and `aws_cloudwatch_metric_alarm` resources to control Auto Scaling"
}

variable "scale_up_cooldown_seconds" {
  type        = number
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_up_scaling_adjustment" {
  type        = number
  default     = 1
  description = "The number of instances by which to scale. `scale_up_adjustment_type` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_up_adjustment_type" {
  type        = string
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_up_policy_type" {
  type        = string
  default     = "SimpleScaling"
  description = "The scalling policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`"
}

variable "scale_down_cooldown_seconds" {
  type        = number
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_down_scaling_adjustment" {
  type        = number
  default     = -1
  description = "The number of instances by which to scale. `scale_down_scaling_adjustment` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_down_adjustment_type" {
  type        = string
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_down_policy_type" {
  type        = string
  default     = "SimpleScaling"
  description = "The scalling policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`"
}

variable "cpu_utilization_high_evaluation_periods" {
  type        = number
  default     = 2
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_high_period_seconds" {
  type        = number
  default     = 300
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_high_threshold_percent" {
  type        = number
  default     = 90
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_high_statistic" {
  type        = string
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}

variable "cpu_utilization_low_evaluation_periods" {
  type        = number
  default     = 2
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_low_period_seconds" {
  type        = number
  default     = 300
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_low_threshold_percent" {
  type        = number
  default     = 10
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_low_statistic" {
  type        = string
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}

variable "iam-role-name" {
  description = "The IAM role to assign to the instance"
  type        = string
  default     = ""
}

variable "instance-associate-public-ip" {
  description = "Defines if the EC2 instance has a public IP address."
  type        = string
  default     = "true"
}

variable "public_key_name" {
  description = "ssh pub key name"
  type        = string
}
