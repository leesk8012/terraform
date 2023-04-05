provider "aws" {
#   region = "ap-northeast-2"
#   shared_credentials_file = "~/.aws/credentials"
#   profile                 = "default"
}

// terrafrom state 파일용 lock 테이블
resource "aws_dynamodb_table" "terraform_state_lock" {
  name = "TerraformStateLock"
  read_capacity = 1
  write_capacity = 1
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

// 로그 저장용 버킷
resource "aws_s3_bucket" "logs" {
  bucket = "rational-root.logs"
  tags = {
    Name        = "rational-root_logs"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "rational-root_logs_acl" {
  bucket = aws_s3_bucket.logs.id
  acl    = "log-delivery-write"
}

// Terraform state 저장용 S3 버킷
resource "aws_s3_bucket" "terraform-state" {
  bucket = "rational-root.terraform.state"
  tags = {
    Name = "terraform state"
  }
  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform-state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}