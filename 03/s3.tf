# pick up a 6 digit random string
resource "random_id" "bucket_suffix" {
  byte_length = 6
}

# create an S3 bucket with the random string as part of the name to ensure uniqueness
resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket-${random_id.bucket_suffix.hex}"
}

# prints bucket name to screen after terraform apply
output "bucket_name" {
  value = aws_s3_bucket.example_bucket.bucket
}