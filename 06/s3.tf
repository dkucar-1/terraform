resource "random_id" "bucket_suffix" {
  byte_length = 4
}
resource "aws_s3_bucket" "static_website" {
  bucket = "my-terraform-s3-bucket-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "My S3 Bucket"
    Environment = "Production"
    Project     = "Terraform S3"
  }
}

resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_website.arn}/*" # automatically adds arn:aws.. stuff
      }
    ]
  })

  # to avoid potential race condition where the bucket policy is created before the bucket and public access block are fully set up
  depends_on = [aws_s3_bucket.static_website, aws_s3_bucket_public_access_block.static_website]
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.static_website.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.static_website.id
  key    = "error.html"
  source = "error.html"
  content_type = "text/html"
}