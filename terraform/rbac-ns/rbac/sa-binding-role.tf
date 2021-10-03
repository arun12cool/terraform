/*
resource "kubernetes_service_account" "sa" {
  for_each            = var.sa
  metadata {
    name = "lookup(each.value, "name", null)"
  }
  secret {
    name = "${kubernetes_secret.sa.metadata.0.name}"
  }
}


resource "kubernetes_cluster_role" "sa_role" {
  metadata {
    name = "sa-role" 
  }

  rule {
    api_groups = ["*"]
    resources  = var.sa-resources
    verbs      = var.sa-verbs
  }

}

resource "kubernetes_cluster_role_binding" "sa_rb" {
  metadata {
    name = "${var.sa}-rb"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "sa-role"
  }
  subject {
    kind      = "Service"
    name      = var.sa
    api_group = "rbac.authorization.k8s.io"
    
  }
}
*/


