resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "K8PractiseBuckeybyArjun"
    Environment = "Dev"
  }
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Disabled"
  }
}