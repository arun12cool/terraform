terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
  }
}

variable "test_region" {
  type    = string
  default = "us-west-2"
}

provider "aws" {
  region = var.test_region
}

module "test" {
  source = "../.."
}

locals {
  wanted_name = "arun-cs-paas-test-bucket"
}

resource "test_assertions" "bucket_name" {

  component = "bucket_name"

  equal "name" {
    description = "Check my bucket name"
    got         = module.test.bucket_name
    want        = "arun-cs-paas-test-bucket"
  }

  check "name_prefix" {
    description = "Check for prefix"
    condition   = can(regex("^arun", module.test.bucket_name))
  }
}

data "aws_s3_bucket" "s3_response" {
  bucket     = module.test.bucket_name
  depends_on = [test_assertions.bucket_name]
}

resource "test_assertions" "s3_region" {
  component = "bucket_region_from_aws"

  equal "region" {
    description = "Check region"
    got         = data.aws_s3_bucket.s3_response.region
    want        = "us-west-2"
  }
}
