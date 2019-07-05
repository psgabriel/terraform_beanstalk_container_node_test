variable "env_name" {
    description = "external info"
}
variable "env_version" {
    description = "external info"
}
variable "application_name" {
    default     = "${var.env_name}"
}
variable "application_environment" {
    default     = "${var.env_name}"
}
variable "application_description" {
    default     = "stg"
}
variable "application_version" {
    default     = "${var.env_version}"
}
variable "instance_type" {
    default     = "t2.micro"
}
variable "aws_region_zone" {
    default     = "us-east-1b"
}
variable "bean_autoscaling_min" {
  default     = "2"
}
variable "bean_rolling_update_type" {
  default     = "Health"
  description = "Health, Immutable, Rolling"
}