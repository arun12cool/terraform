
############ Custom Policy ################


data "aws_iam_policy_document" "policy_1" {
  statement {
      actions = ["*"]
      effect = "Allow"
      resources = ["*"]
      principals {
      type        = "AWS"
      identifiers = ["*"]
      }
   }
}

################################################


resource "aws_security_group" "secgrp_1" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.base.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.base.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags        = merge(local.common_tags, map("Name", "${var.vpc_name}"))
  
}
