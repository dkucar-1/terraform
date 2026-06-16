output "s3_bucket_name" {
  value     = aws_s3_bucket.example.bucket
  sensitive = true
}

output "sensitive_variable" {
  value = var.my_sensitive_variable
  sensitive = true
}