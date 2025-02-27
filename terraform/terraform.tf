terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.85.0"
    }
  }
  required_version = "1.10.5"
}

provider "aws" {
  region = "eu-central-1" # Set the AWS region
}
