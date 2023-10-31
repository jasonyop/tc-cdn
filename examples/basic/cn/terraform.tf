terraform {
  required_version = ">= 1.0, < 2.0"
  backend "s3" {
    region         = "ap-southeast-1"
    bucket         = "sige-test-terragrunt-s3-backend"
    key            = "tencentcloud-web-server-cdn/basic/cn/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "sige-test-terragrunt-s3-backend"
  }
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
  }
}
