# This is the groundwork for a a backend hosted in s3 and locked by DynamoDB.
# The s3 buckets and DynamoDB table resources are NOT included in this repo. They need to be stood up separately.

terraform {
  backend "s3" {
    bucket = "example-s3-bucket"
    region = "us-east-1"
    key = "example/example.tfstate"
    dynamodb_table = "example-tf-state"
    encrypt = true
  }
}