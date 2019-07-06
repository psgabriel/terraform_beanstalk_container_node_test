variable "aws_region_zone" {
    default     = "us-east-1b"
}
variable "vpc_id" {
  default     = "vpc-09f54db1f45172cad"
}
variable "subnet_ec2_elb" {
  default     = "subnet-07e2b167ded4f22c1"
}
variable "bean_autoscaling_min" {
  default     = "2"
}
variable "bean_rolling_update_type" {
  default     = "Health"
  description = "Health, Immutable, Rolling"
}