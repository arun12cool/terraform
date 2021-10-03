## Local variables
locals {
    additional_cidr_block_priv = "10.0.0.0/22"
    additional_cidr_block_pub = "10.0.3.0/24"
    az_list      = ["us-west-2a","us-west-2b","us-west-2c"]
    local_newbits = "2"
    vpc_id = "vpc-123456"

}


###  Additional CIDR Association
resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = local.vpc_id
  cidr_block = local.additional_cidr_block_priv
}


###### CIDR block Split#############################333
###private ##############
module "subnet_addrs_additional_cidr_priv" {
  source = "hashicorp/subnets/cidr"
  base_cidr_block = local.additional_cidr_block_priv
  networks = [
    {
      name     = local.az_list[0]
      new_bits = local.local_newbits
    },
    {
      name     = local.az_list[1]
      new_bits = local.local_newbits
    },
    {
      name     = local.az_list[2]
      new_bits = local.local_newbits
    }
  ]
}

### Public ####

module "subnet_addrs_additional_cidr_pub" {
  source = "hashicorp/subnets/cidr"
  base_cidr_block = local.additional_cidr_block_pub
  networks = [
    {
      name     = local.az_list[0]
      new_bits = local.local_newbits
    },
    {
      name     = local.az_list[1]
      new_bits = local.local_newbits
    },
    {
      name     = local.az_list[2]
      new_bits = local.local_newbits
    }
  ]
}

######### Subnet pub and Priv ##############
resource "aws_subnet" "additional_cidr_block_priv" {
  count             = length(local.az_list)
  vpc_id            = local.vpc_id
  cidr_block        = element(module.subnet_addrs_additional_cidr_priv.networks[*].cidr_block, count.index)
  availability_zone = local.az_list[count.index]
  tags   = merge(local.common_tags, tomap({"Name" = "fargate-private-additional-cidr-subnet"}))   


}

resource "aws_subnet" "additional_cidr_block_pub" {
  count             = length(local.az_list)
  vpc_id            = local.vpc_id
  cidr_block        = element(module.subnet_addrs_additional_cidr_pub.networks[*].cidr_block, count.index)
  availability_zone = local.az_list[count.index]
  tags   = merge(local.common_tags, tomap({"Name" = "fargate-pub-additional-cidr-subnet"}))    
}


data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [local.vpc_id]
  }
}

resource "aws_eip" "nat" {
  count = length(local.az_list)
  vpc   = true
  tags   = local.common_tags
}

resource "aws_route_table" "additional_cidr_public" {
  vpc_id = local.vpc_id
  tags   = merge(local.common_tags, tomap({"Name" = "fargate-pub-additional-cidr-rtb"}))
  }

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.additional_cidr_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = data.aws_internet_gateway.default.id
}

resource "aws_route_table_association" "public" {
  count          = length(local.az_list)
  subnet_id      = element(aws_subnet.additional_cidr_block_pub.*.id, count.index)
  route_table_id = aws_route_table.additional_cidr_public.id
}


resource "aws_nat_gateway" "ngw" {
  count         = length(local.az_list)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.additional_cidr_block_pub.*.id, count.index)
  tags          = local.common_tags
  depends_on    = [aws_eip.nat]
}





########Private#####################

resource "aws_route" "private_nat_gateway" {
  count                  = length(local.az_list)
  route_table_id         = aws_route_table.additional_cidr_private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[count.index].id
}


resource "aws_route_table" "additional_cidr_private" {
  count  = length(local.az_list)
  vpc_id = local.vpc_id
  tags   = merge(local.common_tags, tomap({"Name" = "fargate-private-additional-cidr-rtb"}))   
}

resource "aws_route_table_association" "private" {
  count          = length(local.az_list)
  subnet_id      = element(aws_subnet.additional_cidr_block_priv.*.id, count.index)
  route_table_id = element(aws_route_table.additional_cidr_private.*.id, count.index)
}



####### NACL #######


############   NACL  ###########################
resource "aws_network_acl" "add" {
  vpc_id     = local.vpc_id
  subnet_ids = aws_subnet.additional_cidr_block_pub.*.id
  tags   = local.common_tags
}


#### Allow ALL ############################################
resource "aws_network_acl_rule" "allow_ingress_to_internet" {
  network_acl_id = aws_network_acl.add.id
  rule_number    = 100
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}
resource "aws_network_acl_rule" "allow_egress_to_internet" {
  network_acl_id = aws_network_acl.add.id
  rule_number    = 101
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}
