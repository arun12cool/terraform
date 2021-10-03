################################
#  cluster view role
resource "aws_iam_role" "    _cluster_viewer" {
  assume_role_policy = data.aws_iam_policy_document.Federated_SAML_assume_role_policy.json
  name               = "cs-paas-cluster-viewer"    #${var.cluster_name}-${local.    _cluster_viewer}"
  inline_policy {
    name   = "update-kubeconfig"
    policy = data.aws_iam_policy_document.inline_policy.json
  }

}

#  cluster editor role
resource "aws_iam_role" "    _cluster_editor" {
  assume_role_policy = data.aws_iam_policy_document.Federated_SAML_assume_role_policy.json
  name               = "cs-paas-cluster-editor"
  #"${var.cluster_name}-${local.    _cluster_editor}"
  
  inline_policy {
    name   = "update-kubeconfig"
    policy = data.aws_iam_policy_document.inline_policy.json
  }
}

# cluster admin role
resource "aws_iam_role" "    _cluster_admin" {
  assume_role_policy = data.aws_iam_policy_document.Federated_SAML_assume_role_policy.json
  name               =  "cs-paas-cluster-admin"
#"${var.cluster_name}-${local.    _cluster_admin}"
  
  inline_policy {
    name   = "update-kubeconfig"
    policy = data.aws_iam_policy_document.inline_policy.json
  }
}




