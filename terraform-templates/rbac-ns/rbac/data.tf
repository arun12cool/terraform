data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "Federated_SAML_assume_role_policy" {
  statement {
    sid     = "DLUserTrustDocument"
    actions = ["sts:AssumeRoleWithSAML"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "SAML:aud"
      values   = ["https://saws"]
    }

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:saml-provider/saml-for-aws-mfa"]
      type        = "Federated"
    }
  }
}


data "aws_iam_policy_document" "inline_policy" {
  statement {
    actions   = ["eks:DescribeCluster"]
    resources = ["arn:aws:eks:us-west-2:${data.aws_caller_identity.current.account_id}:cluster/${var.cluster_name}"]
  }
}

#######################################



