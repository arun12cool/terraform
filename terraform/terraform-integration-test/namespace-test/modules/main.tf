resource "kubernetes_namespace" "k8s" {
  for_each = var.namespace

  metadata {
    annotations = lookup(each.value, "annotations", null)
    labels      = lookup(each.value, "labels", null)
    name        = lookup(each.value, "name", null)
  }
}



output "name" {
  value = values(kubernetes_namespace.k8s)[*].id
  
}

/*output "name-1" {
  value = values(kubernetes_namespace.k8s)[0].id
  
}

output "name-2" {
  value = values(kubernetes_namespace.k8s)[1].id
}

output "name-3" {
  value = values(kubernetes_namespace.k8s)[2].id
}*/