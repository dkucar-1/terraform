terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      Name        = "06-networking"
      Environment = "prod"
      Project     = "Terraform Networking"
    }
  }
}
