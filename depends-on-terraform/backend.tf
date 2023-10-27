terraform {
  backend "s3" {
    bucket         = "theinfinitebucketinthisaccount"
    key            = "my-terraform-environment-arbitary-stuff/main"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock"
  }
}
