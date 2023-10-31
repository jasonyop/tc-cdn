terraform {
  required_version = ">= 1.0, < 2.0"
  required_providers {
    null = {
      version = "~> 3.0"
      source  = "hashicorp/null"
    }
    random = {
      version = "~> 3.0"
      source  = "hashicorp/random"
    }
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = "~> 1.0"
    }
    st-utilities = {
      version = "~> 0.1"
      source  = "myklst/st-utilities"
    }
  }
}

provider "tencentcloud" {
  region     = var.cdn_domains.region
  secret_id  = var.cloud_creds.tencentcloud.secret_id
  secret_key = var.cloud_creds.tencentcloud.secret_key
}
