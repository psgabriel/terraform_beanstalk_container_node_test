#Container Confs
resource "aws_s3_bucket" "default" {
  bucket    = "node-staging"
  acl       = "public-read"
}
resource "aws_s3_bucket_object" "default" {
  bucket = "${aws_s3_bucket.default.bucket}"
  key    = "node-staging-dockerrun"
  source = "./Dockerrun.aws.json"
}