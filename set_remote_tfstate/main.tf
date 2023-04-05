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
  bucket = "rational_root.logs"
  acl    = "log-delivery-write"
}

// Terraform state 저장용 S3 버킷
resource "aws_s3_bucket" "terraform-state" {
  bucket = "rational_root.terraform.state"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags {
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