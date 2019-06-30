resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
}
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}
resource "aws_route_table" "public-subnet" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }
}
resource "aws_subnet" "public-subnet" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet}"
    availability_zone = "${var.aws_region_zone}"
}
resource "aws_subnet" "private-subnet" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet}"
    availability_zone = "${var.aws_region_zone}"
}