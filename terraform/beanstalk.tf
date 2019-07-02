# Beanstalk App
resource "aws_elastic_beanstalk_application" "default" {
  name        = "${var.application_name}"
  description = "${var.application_description}"
}
resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "${var.application_name}-${var.application_version}"
  application = "${var.application_name}"
  bucket      = "${aws_s3_bucket.default.id}"
  key         = "${aws_s3_bucket_object.default.id}"

  lifecycle {
    create_before_destroy = true
  }
}
# Benstalk Env
resource "aws_elastic_beanstalk_environment" "staging" {
  name                = "${var.application_environment}"
  application         = "${aws_elastic_beanstalk_application.default.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.12.14 running Docker 18.06.1-ce"
  version_label       = "${aws_elastic_beanstalk_application_version.default.name}"
  tier                = "WebServer"

  # Instance VPC
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${aws_vpc.default.id}"
  }

  # ELB subnet
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${aws_subnet.default.id}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "${var.instance_type}"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "2"
  }
  # Instances subnet
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${aws_subnet.default.id}"
  }
  #
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }
  # Example of setting environment variables
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_ENVIRONMENT"
    value     = "test"
  }
  # Multizone Load Balancers
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = "true"
  }
  # Connection draining
  setting {
    namespace = "aws:elb:policies"
    name      = "ConnectionDrainingEnabled"
    value     = "true"
  }
}
output "cname" {
  value = "${aws_elastic_beanstalk_environment.staging.cname}"
}