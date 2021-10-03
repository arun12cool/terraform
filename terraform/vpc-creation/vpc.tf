resource "aws_vpc" "base" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  instance_tenancy     = var.vpc_tenancy
  tags = merge(local.common_tags, map("Name", "${var.vpc_name}")) 
}
