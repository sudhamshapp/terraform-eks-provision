terraform {
  backend "s3" {
    bucket         = "theinfinitebucketinthisaccount"
    key            = "my-terraform-environment-arbitary/main/user"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock"
  }
}
