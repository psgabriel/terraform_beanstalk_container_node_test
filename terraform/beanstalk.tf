# Beanstalk App
resource "aws_elastic_beanstalk_application" "app" {
    name = "${var.ebs_app_name}"
    description = "${var.ebs_app_description}"
}

# Benstalk Env
resource "aws_elastic_beanstalk_environment" "staging" {
    name = "staging"
    application = "${aws_elastic_beanstalk_application.app.name}"
    solution_stack_name = "${var.ebs_solution_stack_name}"
    tier = "${var.tier}"

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "InstanceType"
        value = "t2.micro"
    }

    setting {
        namespace = "aws:autoscaling:asg"
        name      = "MaxSize"
        value = "2"
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = "${aws_iam_instance_profile.node_beanstalk_ec2.name}"
    }
}
resource "aws_iam_instance_profile" "node_beanstalk_ec2" {
  name  = "node-beanstalk-ec2-user"
  roles = ["${aws_iam_role.node_beanstalk_ec2.name}"]
}
resource "aws_iam_role" "node_beanstalk_ec2" {
  name = "ng-beanstalk-ec2-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_elastic_beanstalk_application_version" "app" {
  name        = "latest"
  application = "${aws_elastic_beanstalk_application.app.name}"
  bucket      = "ebnode"
  key         = "image.zip"

  lifecycle {
    create_before_destroy = true
  }
}