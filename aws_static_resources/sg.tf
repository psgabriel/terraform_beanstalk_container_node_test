resource "aws_security_group" "node-staging" {
    vpc_id = "${aws_vpc.default.id}"
    name = "node-staging"
    description = "Staging App Security Group"
    tags = {
        Name = "node-staging"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
