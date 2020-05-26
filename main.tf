terraform {
  required_version = ">= 0.12, < 0.13"

  required_providers {
    aws    = "~> 2.7"
    random = "~> 2.2"
  }

}

provider "aws" {
  region                  = var.aws_region
  profile                 = var.aws_profile
  shared_credentials_file = var.aws_credentials_path
}