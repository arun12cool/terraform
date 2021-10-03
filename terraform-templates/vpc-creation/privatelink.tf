
module "private_link_customer" {
  source = "repo"

  source_arn                = var.source_arn
  vpc_id                    = aws_vpc.base.id
  instance_type             = var.instance_type
  instance_name             = var.instance_name
  private_subnet_ids        = aws_subnet.private.*.id
  sshkeypair                = var.sshkeypair
  vpc_name                  = var.vpc_name
  target_group_name         = "${var.IAAS_NIC_NAME}-TG"
  nlb_name                  = "${var.IAAS_NIC_NAME}-NLB"
  tags                      = local.common_tags
  count                     = var.customer == true ? 1 : 0
}

