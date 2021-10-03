

# reference : https://registry.terraform.io/modules/hashicorp/subnets/cidr/latest
# Need to add additional blocks if the AZ requirement is more than 3 per module.
# Need to create an additional module if a new CIDR block has to be attached. Ref : private CIDR Block split below



# Private CIDR block Split

module "subnet_addrs_main_cidr_priv" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.vpc_cidr
  networks = [
    {
      name     = var.az_list_priv[0]
      new_bits = var.local_newbits_priv
    },
    {
      name     = var.az_list_priv[1]
      new_bits = var.local_newbits_priv
    },
    {
      name     = var.az_list_priv[2]
      new_bits = var.local_newbits_priv
    }

  ]
}

resource "aws_subnet" "private" {
  count             = length(var.az_list_priv)
  vpc_id            = aws_vpc.base.id
  cidr_block        = element(module.subnet_addrs_main_cidr_priv.networks[*].cidr_block, count.index)
  availability_zone = var.az_list_priv[count.index]
  tags              = merge(local.common_tags, map("Name", "${var.vpc_name}-private-${substr(var.az_list_priv[count.index],-2,-1)}"), map("Iaas_Name", "${var.IAAS_NAME}-private-${var.az_list_priv[count.index]}"))

}


####################################################################################################
### Pub Cidr ###

module "subnet_addrs_main_cidr_pub" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.vpc_cidr_public
  networks = [
    {
      name     = var.az_list_pub[0]
      new_bits = var.local_newbits_pub
    },
    {
      name     = var.az_list_pub[1]
      new_bits = var.local_newbits_pub
    },
    {
      name     = var.az_list_pub[2]
      new_bits = var.local_newbits_pub
    }

  ]
}
resource "aws_subnet" "public" {
  count                   = length(var.az_list_pub)
  vpc_id                  = aws_vpc.base.id
  cidr_block              = element(module.subnet_addrs_main_cidr_pub.networks[*].cidr_block, count.index)
  availability_zone       = var.az_list_pub[count.index]
  map_public_ip_on_launch = true
  tags                    = merge(local.common_tags, map("Name", "${var.vpc_name}-public-${substr(var.az_list_pub[count.index],-2,-1)}"), map("Iaas_Name", "${var.IAAS_NAME}-public-${var.az_list_pub[count.index]}"))

}

###############################################################################################

