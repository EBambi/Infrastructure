provider "aws" {
  region              = "us-east-2"
}

terraform {
  backend "s3" {
    bucket            = "trfm-ste-bkt-final"
    key               = "global/s3/terraform.tfstate"
    region            = "us-east-2"

    dynamodb_table    = "terraform-lock"
    encrypt           = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.1"
    }
  }
}