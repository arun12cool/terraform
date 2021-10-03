

################ Cluster wide ###########################


resource "kubernetes_cluster_role" "    _cluster_viewer" {
  metadata {
    name = local.    _cluster_viewer
  }

  rule {
    api_groups = ["*"]
    resources  = var.resource_cluster_viewer
    verbs      = var.verbs_cluster_viewer
  }

}

resource "kubernetes_cluster_role" "    _cluster_editor" {
  metadata {
    name = local.    _cluster_editor
  }

  rule {
    api_groups = ["*"]
    resources  = var.resource_cluster_editor1
    verbs      = var.verbs_cluster_editor1
  }
  rule {
    api_groups = ["*"]
    resources  = var.resource_cluster_editor2
    verbs      = var.verbs_cluster_editor2
  }
  rule {
    api_groups = ["*"]
    resources  = var.resource_cluster_editor3
    verbs      = var.verbs_cluster_editor3
  }

}

resource "kubernetes_cluster_role" "    _cluster_admin" {
  metadata {
    name = local.    _cluster_admin
  }

  rule {
    api_groups = ["*"]
    resources  = var.resource_cluster_admin
    verbs      = var.verbs_cluster_admin
  }

}

########################################################
