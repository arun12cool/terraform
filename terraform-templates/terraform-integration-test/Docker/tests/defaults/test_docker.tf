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

module "docker" {
  source = "../.."
}

locals {
   container_name = "arun"
   image_name = "ubuntu:precise"
}

#### Chart 1 #####################
resource "test_assertions" "docker1" {
  component = "docker1"

  equal "name" {
    description = "Check my name"
    got         = module.docker.container_name
    want        = local.container_name
  }

  check "name_prefix" {
    description = "Check for prefix"
    condition   = can(regex("^arun", module.docker.container_name))
  }
}


resource "test_assertions" "helm_name" {
  component = "name"
  
  equal "name" {
    description = "image name"
    got         = module.docker.image_name
    want        = local.image_name
  }

}




