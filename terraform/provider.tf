variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

provider "aws" {
  region = "${var.aws_region}"
  profile = "aws"
  shared_credentials_file = "~/.aws/credentials"
}