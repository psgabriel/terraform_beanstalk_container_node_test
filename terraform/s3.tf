#Container Confs
data "template_file" "docker" {
  template = "${file("${path.module}/templates/Dockerrun.aws.json.tpl")}"

  vars = {
    docker_tag       = "${var.docker_tag}"
    docker_image     = "${var.docker_image}"
    docker_ports     = "[ ${join(",\n",formatlist("{ \"ContainerPort\": \"%s\" }", var.docker_ports))} ]"
    application_name = "${var.application_name}"
  }
}
data "archive_file" "zip" {
  type                      = "zip"
  source_content            = "${data.template_file.docker.rendered}"
  source_content_filename   = "Dockerrun.aws.json"
  output_path               = "./dockerrun.zip"
}
resource "aws_s3_bucket" "default" {
  bucket    = "node-stg"
  acl       = "public-read"
}

resource "aws_s3_bucket_object" "default" {
  bucket = "${aws_s3_bucket.default.bucket}"
  key    = "${var.application_name}-dockerrun"
  source = "./dockerrun.zip"
  etag   = "${data.archive_file.zip.output_md5}"
}