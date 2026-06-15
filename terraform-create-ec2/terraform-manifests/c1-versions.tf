# Terraform Block
terraform {
  required_version = "~> 1.15"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
# Provider Block
provider "aws" {
  region = "ap-southeast-1"
  profile = "default"
}

/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/
