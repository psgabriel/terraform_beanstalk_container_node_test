resource "aws_iam_role" "elb_blue" {
  name = "elb_blue"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_role" "elb_green" {
  name = "elb_green"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy" "AWSElasticBeanstalkWebTier" {
  arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}


resource "aws_iam_role_policy_attachment" "elb-attach" {
  role       = "${aws_iam_role.elb_blue.name}"
  policy_arn = "${data.aws_iam_policy.AWSElasticBeanstalkWebTier.arn}"
}
resource "aws_iam_role_policy_attachment" "elb-attach" {
  role       = "${aws_iam_role.elb_green.name}"
  policy_arn = "${data.aws_iam_policy.AWSElasticBeanstalkWebTier.arn}"
}


resource "aws_iam_instance_profile" "elb-profile" {
  name = "elb_blue_profile"
  role = "${aws_iam_role.elb_blue.name}"
}
resource "aws_iam_instance_profile" "elb-profile" {
  name = "elb_green_profile"
  role = "${aws_iam_role.elb_green.name}"
}