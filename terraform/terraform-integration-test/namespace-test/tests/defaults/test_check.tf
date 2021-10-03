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


provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "ns" {
  source = "../.."
}

locals {
  wanted_name = [
  "cloud-1",
  "cloud-2",
  "cloud-5",
]
  /*want-1 = "cloud-1"
  want-2 = "cloud-2"
  want-3 = "cloud-3"*/
}

resource "test_assertions" "ns_name" {

  component = "ns_name"

  equal "name" {
    description = "Check the ns"
    got         = module.ns.ns-name-all
    want        = local.wanted_name
  }

  check "name_prefix" {
    description = "Check for output file"
    condition   = can(module.ns.ns-name-all)
  }
}

/*

data "kubernetes_namespace" "example" {
  metadata {
    name = "cloud-1"
  }
  depends_on = [test_assertions.ns_name]
}

data "kubernetes_namespace" "example2" {
  metadata {
    name = "cloud-2"
  }
  depends_on = [test_assertions.ns_name]
}

data "kubernetes_namespace" "example3" {
  metadata {
    name = "cloud-3"
  }
  depends_on = [test_assertions.ns_name]
}

resource "test_assertions" "ns_1" {
  component = "ns_id1"
  
  equal "id1" {
    description = "Check id1"
    got         = data.kubernetes_namespace.example.id
    want        = local.want-2
  }

}

resource "test_assertions" "ns_2" {
  component = "ns_id2"
  
  equal "id2" {
    description = "Check id2"
    got         = data.kubernetes_namespace.example2.id
    want        = local.want-3
  }

}

resource "test_assertions" "ns_3" {
  component = "ns_id3"
  
  equal "id3" {
    description = "Check id3"
    got         = data.kubernetes_namespace.example3.id
    want        = local.want-1
  }

}

*/