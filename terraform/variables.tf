variable "application_name" {
    default     = "eb_node"
}
variable "application_description" {
    default     = "lab"
}
variable "application_environment" {
    default     = "env-stg"
}
variable "application_version" {
    default     = "1.0.0"
}
variable "docker_tag" {
    default     = "latest"
}
variable "docker_image" {
    default     = "docker.io/psgabriel/node"
}
variable "docker_ports" {
    default     = "8080"
}
variable "instance_type" {
    default     = "t2.micro"
}
variable "aws_region" {
    default     = "us-east-1"
}
variable "aws_region_zone" {
    default     = "us-east-1b"
}