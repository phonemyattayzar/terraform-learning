# Terraform Settings Block
terraform {
  required_version = "~> 1.15.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


# required_providers block မှာ argument name ကို aws လို့ ပေးခဲ့ရင် aws လို့ပဲ ပြန်ခေါ်သုံးရမယ် my aws ဆို my aws
provider "aws" {
  region = "ap-southeast-1"
  profile = "default"
}

