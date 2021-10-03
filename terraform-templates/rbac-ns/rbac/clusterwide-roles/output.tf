### Cluster role Bindings

output "cluster-viewer-crb" {
  value = kubernetes_cluster_role_binding.   _cluster_viewer[*]
}

output "cluster-editor-crb" {
  value = kubernetes_cluster_role_binding.   _cluster_editor[*]
}

output "cluster-admin-crb" {
  value = kubernetes_cluster_role_binding.   _cluster_admin[*]
}



#### Cluster wide iam ####

output "cluster-viewer-iam" {
  value = aws_iam_role.   _cluster_viewer.arn
}

output "cluster-editor-iam" {
  value = aws_iam_role.   _cluster_editor.arn
}

output "cluster-admin-iam" {
  value = aws_iam_role.   _cluster_admin.arn
}



#### Cluster wide roles ####

output "cluster-viewer" {
  value = kubernetes_cluster_role.   _cluster_viewer[*]
}

output "cluster-editor" {
  value = kubernetes_cluster_role.   _cluster_editor[*]
}

output "cluster-admin" {
  value = kubernetes_cluster_role.   _cluster_admin[*]
}
