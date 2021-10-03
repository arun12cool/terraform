# https://github.devtools.predix.io/PCE-CAP/tf_aws_timeseries_vpc_endpoints.git


data "aws_security_group" "default" {

  filter {
    name   = "group-name"
    values = ["default"]
  }

  filter {
    name   = "vpc-id"
    values = ["${aws_vpc.base.id}"]
  }
}


################################################################################
# VPC Endpoints Shared Module
################################################################################

module "vpc_endpoints_shared" {
  source             = "repo"
  vpc_id             = aws_vpc.base.id
  subnet_ids         = aws_subnet.private.*.id
  route_table_ids    = aws_route_table.private.*.id
  security_group_ids = [aws_security_group.secgrp_1.id]
  tags               = merge(local.common_tags, map("Name", "${var.vpc_name}"))
  ssm-path           = var.ssm-path
  count              = var.customer == false ? 1 : 0

  ######### Endpoints ##################
  endpoints = {
    s3       = { service = "s3", private_dns_enabled = "false", policy = "${data.aws_iam_policy_document.policy_1.json}" }
    dynamodb = { service = "dynamodb", service_type = "Gateway" }
    rds      = { service = "rds", policy = "${data.aws_iam_policy_document.policy_1.json}" }
    ssm      = { service = "ssm" }
    kms      = { service = "kms" }
    emr-containers   = { service = "emr-containers" }
    lambda           = { service = "lambda" }
    kinesis-firehose = { service = "kinesis-firehose" }
    kinesis-streams  = { service = "kinesis-streams" }
    secretsmanager   = { service = "secretsmanager" }
  }
  ########################################
}



##################### Customer ##############################

module "vpc_endpoints_customer" {
  source = "repo"

  vpc_id             = aws_vpc.base.id
  subnet_ids         = aws_subnet.private.*.id
  route_table_ids    = aws_route_table.private.*.id
  security_group_ids = [aws_security_group.secgrp_1.id]
  tags               = merge(local.common_tags, map("Name", "${var.vpc_name}"))
  ssm-path           = var.ssm-path
  count              = var.customer == true ? 1 : 0

  ######### Endpoints ##################

  endpoints = {
    s3  = { service = "s3", private_dns_enabled = "false", policy = "${data.aws_iam_policy_document.policy_1.json}"}
    rds = { service = "rds", policy = "${data.aws_iam_policy_document.policy_1.json}" }
    ssm = { service = "ssm" }
    kms = { service = "kms" }
  }
########################################

}
