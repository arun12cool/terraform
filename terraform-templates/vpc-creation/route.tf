###########Public Route ##########################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.base.id
  tags   = merge(local.common_tags, map("Name", "${var.vpc_name}-public-IGW"))
}


resource "aws_eip" "nat" {
  count = length(var.az_list_pub)
  vpc   = true
  tags  = merge(local.common_tags, map("Name", "${var.vpc_name}-public-${substr(var.az_list_pub[count.index], -2, -1)}"), map("Iaas_Name", "${var.IAAS_NAME}-${var.az_list_pub[count.index]}"))

}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id
  tags   = merge(local.common_tags, map("Iaas_Name", "${var.IAAS_NAME}-public"), map("Name", "${var.vpc_name}-public"))
}



resource "aws_route_table_association" "public" {
  count          = length(var.az_list_pub)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}


resource "aws_nat_gateway" "ngw" {
  count         = length(var.az_list_pub)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags          = merge(local.common_tags, map("Iaas_Name", "${var.IAAS_NAME}-${var.az_list_pub[count.index]}"), map("Name", "${var.vpc_name}-${substr(var.az_list_pub[count.index], -2, -1)}"))

  depends_on = [aws_internet_gateway.igw]
}

########Private#####################

resource "aws_route" "private_nat_gateway" {
  count                  = length(var.az_list_priv)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[count.index].id
}


resource "aws_route_table" "private" {
  count  = length(var.az_list_priv)
  vpc_id = aws_vpc.base.id
  tags   = merge(local.common_tags, map("Iaas_Name", "${var.IAAS_NAME}-${var.az_list_priv[count.index]}"), map("Name", "${var.vpc_name}-private-${substr(var.az_list_priv[count.index], -2, -1)}"))
}

resource "aws_route_table_association" "private" {
  count          = length(var.az_list_priv)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}




### Route 53 #################

resource "aws_route53_zone" "base" {
  count = var.enable_route53 == "true" ? 1 : 0
  vpc {
    vpc_id = aws_vpc.base.id
  }
  name = var.zone_name
  tags = local.common_tags
}
