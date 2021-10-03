
resource "kubernetes_role_binding" "  _ns_viewer" {
  for_each = var.namespace
  metadata {
    name      = "${each.key}-${local.  _ns_viewer}"
    namespace = each.key
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = local.  _ns_viewer
  }
  subject {
    kind      = "Group"
    name      = "${each.key}-${local.  _ns_viewer}"
    api_group = "rbac.authorization.k8s.io"
    namespace = each.key
  }

  depends_on = [kubernetes_namespace.k8s-namespace, kubernetes_cluster_role.  _ns_viewer]
}


resource "kubernetes_role_binding" "  _ns_editor" {
  for_each = var.namespace
  metadata {
    name      = "${each.key}-${local.  _ns_editor}"
    namespace = each.key
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = local.  _ns_editor
  }
  subject {
    kind      = "Group"
    name      = "${each.key}-${local.  _ns_editor}"
    api_group = "rbac.authorization.k8s.io"
    namespace = each.key
  }
  depends_on = [kubernetes_namespace.k8s-namespace, kubernetes_cluster_role.  _ns_editor]
}



resource "kubernetes_role_binding" "  _ns_admin" {
  for_each = var.namespace
  metadata {
    name      = "${each.key}-${local.  _ns_admin}"
    namespace = each.key
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = local.  _ns_admin
  }
  subject {
    kind      = "Group"
    name      = "${each.key}-${local.  _ns_admin}"
    api_group = "rbac.authorization.k8s.io"
    namespace = each.key
  }
  depends_on = [kubernetes_namespace.k8s-namespace, kubernetes_cluster_role.  _ns_admin]
}


##########################################################


