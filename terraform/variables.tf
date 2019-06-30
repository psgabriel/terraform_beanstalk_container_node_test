variable "vpc_cidr" {
    default         = "192.168.0.0/16"
}
variable "aws_region" {
    default         = "us-east-1"
}
variable "aws_region_zone" {
    default         = "us-east-1b"
}
variable "public_subnet" {
    default         = "192.168.1.0/24"
}
variable "private_subnet" {
    default         = "192.168.2.0/24"
}
variable "ebs_app_name" {
    default         = "node-myapp"
}
variable "ebs_app_description" {
    default         = ""
}
variable "ebs_solution_stack_name" {
    default         = "64bit Amazon Linux 2018.03 v2.12.14 running Docker 18.06.1-ce"
}
variable "tier" {
    default         = "WebServer"
}
variable "rolling_update_type" {
    default         = "Health"
}
variable "updating_min_in_service" {
    default         = "1"
}
variable "updating_max_batch" {
    default         = "1"
}