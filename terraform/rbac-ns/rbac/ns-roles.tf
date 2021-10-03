
############## Name space based cluster Roles#####################

resource "kubernetes_cluster_role" " _ns_viewer" {
  metadata {
    name = local. _ns_viewer
  }

  rule {
    api_groups = ["*"]
    resources  = var.resource_ns_viewer
    verbs      = var.verbs_ns_viewer
  }
  lifecycle {
    ignore_changes = all
  }
}



resource "kubernetes_cluster_role" " _ns_editor" {
  metadata {
    name = local. _ns_editor
  }

  rule {
    api_groups = ["*"]
    resources  = var.resource_ns_editor1
    verbs      = var.verbs_ns_editor1
  }

  rule {
    api_groups = ["*"]
    resources  = var.resource_ns_editor2
    verbs      = var.verbs_ns_editor2
  }

  rule {
    api_groups = ["*"]
    resources  = var.resource_ns_editor3
    verbs      = var.verbs_ns_editor3
  }
  lifecycle {
    ignore_changes = all
  }
}



resource "kubernetes_cluster_role" " _ns_admin" {
  metadata {
    name = local. _ns_admin
  }

  rule {
    api_groups = ["*"]
    resources  = var.resource_ns_admin
    verbs      = var.verbs_ns_admin
  }
  lifecycle {
    ignore_changes = all
  }

}


