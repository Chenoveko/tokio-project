terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.49.0"
    }
  }
  backend "s3" {
    bucket         = "techwave-tfstate-dev"
    key            = "dev/terraform.tfstate"
    region         = "eu-south-2"
    encrypt        = true
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}