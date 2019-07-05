#Container Confs
resource "aws_s3_bucket" "default" {
  bucket    = "${var.application_name}"
  acl       = "public-read"
}
resource "aws_s3_bucket_object" "default" {
  bucket = "${aws_s3_bucket.default.bucket}"
  key    = "${var.application_name}-dockerrun"
  source = "./Dockerrun.aws.json"
}