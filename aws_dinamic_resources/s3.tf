#Container Confs
resource "aws_s3_bucket" "default" {
  bucket    = "node-stg"
  acl       = "public-read"
}
resource "aws_s3_bucket_object" "default" {
  bucket = "${aws_s3_bucket.default.bucket}"
  key    = "${var.application_name}-dockerrun"
  source = "./Dockerrun.aws.json"
}