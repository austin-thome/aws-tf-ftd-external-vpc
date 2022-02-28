# This is the groundwork for a a backend hosted in s3 and locked by DynamoDB.
# The s3 buckets and DynamoDB table resources are NOT included in this repo. They need to be stood up separately.

terraform {
  backend "s3" {
    bucket = "rr-external-transit-tf-state"
    region = "us-east-1"
    key = "aws-tf-ftd-external-vpc.tfstate"
    dynamodb_table = "tf-state"
    encrypt = true
  }
}