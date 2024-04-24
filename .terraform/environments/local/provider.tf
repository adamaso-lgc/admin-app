terraform {
  backend "s3" {
    bucket                      = "tf-s3-backend-0000"
    key                         = "terraform.tfstate"
    region                      = "eu-west-1"
    endpoint                    = "http://s3.localhost.localstack.cloud:4566"

    dynamodb_table              = "tf-db-backend-0000"
    dynamodb_endpoint           = "http://localhost:4566"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
    encrypt                     = true
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                        = "eu-west-1"
  skip_credentials_validation   = true
  skip_requesting_account_id    = true
  skip_metadata_api_check       = true
  s3_use_path_style             = true

  endpoints {
    s3       = "http://s3.localhost.localstack.cloud:4566"
    dynamodb = "http://localhost:4566"
  }
}