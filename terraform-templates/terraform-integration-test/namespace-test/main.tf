


module "namespaces" {

  source       = "./modules"

  namespace = {
    "${local.namespace1}" = { annotations = "${local.annotations1}", labels = "${local.labels1}", name = "${local.namespace1}" }
    "${local.namespace2}" = { annotations = "${local.annotations2}", labels = "${local.labels2}", name = "${local.namespace2}" }
    "${local.namespace3}" = { annotations = "${local.annotations3}", labels = "${local.labels3}", name = "${local.namespace3}" }
  }

}
provider "kubernetes" {
  config_path = "~/.kube/config"
}
locals {



  ######### Namespaces ##############
  namespace1 = "cloud-1"
  namespace2 = "cloud-2"
  namespace3 = "cloud-3"


  ####### Annotations #################

  annotations1 = { #  variable substitution within a variable
    "name" = "cloud-1"
  }
  annotations2 = { #  variable substitution within a variable
    "name" = "cloud-2"
  }
  annotations3 = { #  variable substitution within a variable
    "name" = "cloud-3"
  }


  ###### Labels ########################    

  labels1 = { #  variable substitution within a variable
    "team" = "cloud-1"
  }
  labels2 = { #  variable substitution within a variable
    "team" = "cloud-2"
  }
  labels3 = { #  variable substitution within a variable
    "team" = "cloud-3"
  }

}




provider "aws" {
  region = "us-west-2"
}


terraform {
  required_providers {
    aws = {
      version = "3.49.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 0.15.0, < 0.15.1"
}


output "ns-name-all" {
  value = module.namespaces.name
}

/*output "ns-name-1" {
  value = module.namespaces.name-1
}

output "ns-name-2" {
  value = module.namespaces.name-2
}

output "ns-name-3" {
  value = module.namespaces.name-3
}*/
