variable "application_name" {
    default     = "node-stg-color"
}
variable "application_description" {
    default     = "node_stg"
}
variable "application_version" {
    default     = "1.0.0"
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