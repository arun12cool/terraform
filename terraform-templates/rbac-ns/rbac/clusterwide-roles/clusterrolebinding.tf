
resource "kubernetes_cluster_role_binding" "    _cluster_viewer" {

   
  metadata {
    name = local.    _cluster_viewer
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = local.    _cluster_viewer
  }
  subject {
    kind      = "Group"
    name      = local.    _cluster_viewer
    api_group = "rbac.authorization.k8s.io"

  }

  depends_on = [kubernetes_cluster_role.    _cluster_viewer]

  lifecycle {
    ignore_changes = all
  }
}

resource "kubernetes_cluster_role_binding" "    _cluster_editor" {

  
  metadata {
    name = local.    _cluster_editor
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = local.    _cluster_editor
  }
  subject {
    kind      = "Group"
    name      = local.    _cluster_editor
    api_group = "rbac.authorization.k8s.io"

  }
 
  depends_on = [kubernetes_cluster_role.    _cluster_editor]

  lifecycle {
    ignore_changes = all
  }

}


resource "kubernetes_cluster_role_binding" "    _cluster_admin" {


  metadata {
    name = local.    _cluster_admin
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = local.    _cluster_admin
  }
  subject {
    kind      = "Group"
    name      = local.    _cluster_admin
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [kubernetes_cluster_role.    _cluster_admin]



}
