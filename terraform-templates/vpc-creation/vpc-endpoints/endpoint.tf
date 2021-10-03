locals {
  endpoints = var.endpoints
  ssm-path = var.ssm-path
}



################################################################################
# Endpoint Data
################################################################################

data "aws_caller_identity" "current" {}


data "aws_vpc_endpoint_service" "endpoint" {
  for_each     = local.endpoints
  service      = lookup(each.value, "service", null)
  service_name = lookup(each.value, "service_name", null)

  filter {
    name   = "service-type"
    values = [lookup(each.value, "service_type", "Interface")]
  }
}



################################################################################
# Endpoint Resource
################################################################################

resource "aws_vpc_endpoint" "endpoint" {
  for_each            = local.endpoints
  vpc_id              = var.vpc_id
  service_name        = data.aws_vpc_endpoint_service.endpoint[each.key].service_name
  vpc_endpoint_type   = lookup(each.value, "service_type", "Interface")
  auto_accept         = lookup(each.value, "auto_accept", true)
  security_group_ids  = lookup(each.value, "service_type", "Interface") == "Interface" ?  var.security_group_ids : null
  subnet_ids          = lookup(each.value, "service_type", "Interface") == "Interface" ? var.subnet_ids : null
  route_table_ids     = lookup(each.value, "service_type", "Interface") == "Gateway" ? var.route_table_ids : null
  policy              = lookup(each.value, "policy", null)
  private_dns_enabled = lookup(each.value, "service_type", "Interface") == "Interface" ? lookup(each.value, "private_dns_enabled", true) : null
  tags                = var.tags

}


################################################################################
# SSM Parameter Store
################################################################################




resource "aws_ssm_parameter" "endpoint" {
  for_each    = local.endpoints
  name        = "${local.ssm-path}/${data.aws_vpc_endpoint_service.endpoint[each.key].service}"
  type        = "String"
  value       = aws_vpc_endpoint.endpoint[each.key].id
  tags        = merge(var.tags, map("Name", "${local.ssm-path}"))


  depends_on = [aws_vpc_endpoint.endpoint]
}
