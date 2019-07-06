# Beanstalk App
resource "aws_elastic_beanstalk_application" "default" {
  name        = "${var.application_name}"
  description = "${var.application_description}"
}
resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "${var.application_name}-${var.application_version}"
  application = "${aws_elastic_beanstalk_application.default.name}"
  bucket      = "node-staging"
  key         = "node-staging-dockerrun"

  lifecycle {
    create_before_destroy = true
  }
}
# Benstalk Env
resource "aws_elastic_beanstalk_environment" "default" {
  name                = "${var.application_name}"
  application         = "${aws_elastic_beanstalk_application.default.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.12.14 running Docker 18.06.1-ce"
  version_label       = "${aws_elastic_beanstalk_application_version.default.name}"
  tier                = "WebServer"

  # Instance VPC
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "vpc-037db2482fad83358"
  }

  # ELB and Instances subnet
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "subnet-07603443cf6865827"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "subnet-07603443cf6865827"
  }
  # Autoscaling
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
  # Beanstalk Load Balancer Confs
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = "true"
  }
  setting {
    namespace = "aws:elb:policies"
    name      = "ConnectionDrainingEnabled"
    value     = "true"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MinInstancesInService"
    value     = "${var.bean_autoscaling_min}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "${var.bean_rolling_update_type == "Immutable" ? "Immutable" : "Rolling"}"
  }
  # setting {
  #   namespace = "aws:elasticbeanstalk:application:default"
  #   name      = "url"
  #   value     = "${aws_elastic_beanstalk_environment.default.cname}"
  # }
}
output "cname" {
  value = "${aws_elastic_beanstalk_environment.default.cname}"
}