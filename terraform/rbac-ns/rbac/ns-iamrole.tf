



# namespace view role
resource "aws_iam_role" " _ns_viewer" {
  for_each           = var.namespace
  assume_role_policy = data.aws_iam_policy_document.Federated_SAML_assume_role_policy.json
  name               = "${each.key}-${local. _ns_viewer}"
  inline_policy {
    name   = "update-kubeconfig"
    policy = data.aws_iam_policy_document.inline_policy.json
  }
}

# namespace edit role
resource "aws_iam_role" " _ns_editor" {
  for_each           = var.namespace
  assume_role_policy = data.aws_iam_policy_document.Federated_SAML_assume_role_policy.json
  name               = "${each.key}-${local. _ns_editor}"
  inline_policy {
    name   = "update-kubeconfig"
    policy = data.aws_iam_policy_document.inline_policy.json
  }
  depends_on         = [aws_iam_role. _ns_viewer, kubernetes_namespace.k8s-namespace]
}


# namespace admin role
resource "aws_iam_role" " _ns_admin" {
  for_each           = var.namespace
  assume_role_policy = data.aws_iam_policy_document.Federated_SAML_assume_role_policy.json
  name               = "${each.key}-${local. _ns_admin}"
  inline_policy {
    name   = "update-kubeconfig"
    policy = data.aws_iam_policy_document.inline_policy.json
  }
  depends_on         = [aws_iam_role. _ns_viewer, aws_iam_role. _ns_editor, kubernetes_namespace.k8s-namespace]
}


