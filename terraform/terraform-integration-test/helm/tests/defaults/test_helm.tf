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

module "helm" {
  source = "../.."
}

locals {
  chart_id = "helm-demo-ms-app"
  chart_id1 = "https://charts.bitnami.com/bitnami/redis-10.7.16.tgz"
  chart_name = "arun-chart"
  chart_name1 = "redis"
  chart_status = "deployed"
  chart_status1 = "deployed" 
}

#### Chart 1 #####################
resource "test_assertions" "helm1" {
  component = "helm1"

  equal "name" {
    description = "Check my name"
    got         = module.helm.chart_id
    want        = local.chart_id
  }

  check "name_prefix" {
    description = "Check for prefix"
    condition   = can(regex("^helm", module.helm.chart_id))
  }
}


resource "test_assertions" "helm_name" {
  component = "name"
  
  equal "name" {
    description = "Check name"
    got         = module.helm.chart_name
    want        = local.chart_name
  }

}

resource "test_assertions" "helm_status" {
  component = "status"
  
  equal "status" {
    description = "Check name"
    got         = module.helm.chart_status
    want        = local.chart_status
  }

}

####### Chart 2 #######

resource "test_assertions" "helm2" {
  component = "helm2"

  equal "name" {
    description = "Check my name"
    got         = module.helm.chart_id1
    want        = local.chart_id1
  }

  check "name_prefix" {
    description = "Check for prefix"
    condition   = can(regex("^https", module.helm.chart_id1))
  }
}



resource "test_assertions" "helm_name2" {
  component = "name2"
  
  equal "name" {
    description = "Check name"
    got         = module.helm.chart_name1
    want        = local.chart_name1
  }

}

resource "test_assertions" "helm_status2" {
  component = "status2"
  
  equal "status" {
    description = "Check name"
    got         = module.helm.chart_status1
    want        = local.chart_status1
  }

}
