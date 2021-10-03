module "default_nacl" {
  source              = "git::https://github.devtools.predix.io/PCE-CAP/tf_aws_timeseries_default_nacl?ref=1.0.0"
  vpc_default_nacl_id = aws_vpc.base.default_network_acl_id
  vpc_id              = aws_vpc.base.id
  tags                = merge(local.common_tags, map("Iaas_Name", "${var.IAAS_NAME}-default"), map("Name", "${var.vpc_name}-default"))
}

module "public_base_nacl" {
  source              = "git::https://github.devtools.predix.io/PCE-CAP/tf_aws_timeseries_nacl.git?ref=1.0.0"
  allow_https         = var.public_subnets_allow_https
  allow_ntp           = true
  allow_vpn           = var.public_subnets_allow_vpn
  nacl_name           = "${var.vpc_name}-public-nacl"
  subnet_ids          = aws_subnet.public.*.id
  vpc_id              = aws_vpc.base.id
  vpc_default_nacl_id = aws_vpc.base.default_network_acl_id
  tags                = merge(local.common_tags, map("Iaas_Name", "${var.IAAS_NAME}-public"), map("Name", "${var.vpc_name}-public"))
}

module "private_base_nacl" {
  source              = "git::https://github.devtools.predix.io/PCE-CAP/tf_aws_timeseries_nacl.git?ref=1.0.0"
  allow_https         = var.private_subnets_allow_https
  allow_ntp           = true
  nacl_name           = "${var.vpc_name}-private-nacl"
  subnet_ids          = aws_subnet.private.*.id
  vpc_id              = aws_vpc.base.id
  vpc_default_nacl_id = aws_vpc.base.default_network_acl_id
  tags                = merge(local.common_tags, map("Iaas_Name", "${var.IAAS_NAME}-private"), map("Name", "${var.vpc_name}-private"))
}
