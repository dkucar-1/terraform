resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "example" {
  bucket = "${local.project_owner}-${random_id.bucket_suffix.hex}"
  tags   = local.common_tags
}
