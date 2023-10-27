terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.22"  # Automatically selects the latest 3.x version
    }
  }
}

provider "aws" {
  # Configuration options
}
