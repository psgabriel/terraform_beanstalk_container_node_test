resource "aws_security_group" "sg_app-staging" {
    vpc_id = "${aws_vpc.default.id}"
    name = "sg_app-staging"
    description = "Staging App Security Group"
    tags = {
        Name = "sg_app-staging"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
