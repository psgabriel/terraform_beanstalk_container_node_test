# Instances VPC
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
    tag = {
      Name = "VPC for ${var.application_name}"
  }
}

# To access outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

# Grant the VPC internet access
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Subnet for ELB and EC2 instances
resource "aws_subnet" "default" {
  vpc_id                  = "${aws_vpc.default.id}"
  availability_zone       = "${var.aws_region_zone}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet for ${var.application_name}"
  }
}