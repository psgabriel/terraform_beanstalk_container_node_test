provider "aws" {
  region = "${var.aws_region}"
  profile = "aws"
  shared_credentials_file = "~/.aws/credentials"
}