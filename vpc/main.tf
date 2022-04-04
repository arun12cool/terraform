# Fill up the local variables and the tags in the locals.tf file

## ------ Keep local edits above this line --------

## VPC module creation
module "zeta" {
  source      = "./modules"
  vpc_cidr    = local.local_vpc_cidr
  vpc_tenancy = "default"
  //enable_route53   = false   # Has to be removed/commented if you dont want DNS entry to be created
  vpc_name           = local.local_vpc_name
  vpc_cidr_public    = local.local_public_cidr
  az_list_priv       = local.az_list_priv
  az_list_pub        = local.az_list_pub
  local_newbits_priv = local.local_newbits_priv
  local_newbits_pub  = local.local_newbits_priv
  zone_name          = local.zone_name
  zone_id            = local.zone_id

}





## Local variables for VPC          
locals {
  local_newbits_priv = "2"
  local_newbits_pub  = "2"
  local_vpc_cidr     = "10.1.68.0/22"
  local_public_cidr  = "10.1.71.0/24"
  local_vpc_name     = "zeta-1"
  az_list_priv       = ["us-west-2a", "us-west-2b", "us-west-2c"] # Add more AZ's if required
  az_list_pub        = ["us-west-2a", "us-west-2b", "us-west-2c"]
  zone_id            = ["usw2-az1", "usw2-az2", "usw2-az3"]
  zone_name          = "customer-1"
}