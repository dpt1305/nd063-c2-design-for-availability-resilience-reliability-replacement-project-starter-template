terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
	alias = "az1"
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  # profile                  = "default"
}
provider "aws" {
	alias = "az2"
  region                   = "us-west-2"
  shared_credentials_files = ["~/.aws/credentials"]
  # profile                  = "default"
}