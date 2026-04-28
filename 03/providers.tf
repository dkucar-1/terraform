terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket       = "my-terraform-state-bucket" # must exist
    key          = "terraform.tfstate"
    region       = "us-west-2"
    use_lockfile = true  # use S3's locking mechanism to prevent concurrent modifications to the state file
  }
}

provider "aws" {
  region = "us-west-2"
}
