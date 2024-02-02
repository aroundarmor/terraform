terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  # shared_config_files      = ["/Users/sauravpatel/.aws/config"]
  # shared_credentials_files = ["/Users/sauravpatel/.aws/creds"]
  # profile                  = "default"

  default_tags {
    tags = {
      Environment = "Dev"
      Service = "EC2Instance"
    }
  }
}