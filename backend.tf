terraform {
  backend "s3" {
    bucket         = "bucket-hw-devops"    
    key            = "lesson-5/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
