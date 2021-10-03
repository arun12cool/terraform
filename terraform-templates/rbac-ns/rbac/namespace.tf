resource "kubernetes_namespace" "k8s-namespace" {
  for_each = var.namespace

  metadata {
    annotations = lookup(each.value, "annotations", null)
    labels      = lookup(each.value, "labels", null)
    name        = lookup(each.value, "name", null)
  }
}

