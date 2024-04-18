terraform {
    backend "s3" {
        bucket = "tfstate-will-epam-final-task"
        key = "state/terraform.tfstate"
        encrypt = true
        region = "us-east-1"
        dynamodb_table = "epam-tf-lockid"
    }
}