terraform {
    backend "s3" {
        bucket = "tfstate-will-epam-final-task"
        key = "state/terraform.tfstate"
        encrypt = true
        region = "us-east-1"
        dynamodb_table = "epam-tf-lockid"
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "test-s3-bucket-from-tf" {
    bucket = "test-s3-bucket-from-tf"
}