

### Namespace Roles ####

output "ns-viewer" {
  value = kubernetes_cluster_role.  _ns_viewer.id
}

output "ns-editor" {
  value = kubernetes_cluster_role.  _ns_editor.id
}


output "ns-admin" {
  value = kubernetes_cluster_role.  _ns_admin.id
}


## Role bindings ##

output "ns-viewer-rb" {
  value = {for r, b in kubernetes_role_binding.  _ns_viewer: r => b.id}
  #kubernetes_role_binding.  _ns_viewer[*]
}

output "ns-editor-rb" {
  value = {for r, b in kubernetes_role_binding.  _ns_editor: r => b.id}
  #kubernetes_role_binding.  _ns_editor[*]
}

output "ns-admin-rb" {
  value = {for r, b in kubernetes_role_binding.  _ns_admin: r => b.id}
  #kubernetes_role_binding.  _ns_admin[*]
}


output "ns-viewer-rb-list" {
  value = values(kubernetes_role_binding.  _ns_viewer)[*].id
  #kubernetes_role_binding.  _ns_viewer[*]
}

output "ns-editor-rb-list" {
  value = values(kubernetes_role_binding.  _ns_editor)[*].id
  #kubernetes_role_binding.  _ns_editor[*]
}

output "ns-admin-rb-list" {
  value = values(kubernetes_role_binding.  _ns_admin)[*].id
  #kubernetes_role_binding.  _ns_admin[*]
}






### Namespace

output "namespace" {
  value = {for k, v in kubernetes_namespace.k8s-namespace: k => v.id}
  #values(kubernetes_namespace.k8s-namespace)[*].id
}

### or 
output "namespaces-list" {
  value = values(kubernetes_namespace.k8s-namespace)[*].id
}


### IAM Roles NS ####

output "ns-viewer-iam" {
  value = {for k, v in aws_iam_role.  _ns_viewer: k => v.name}
  #value = {for viewer in aws_iam_role.  _ns_viewer : viewer.name => {
  #    name = viewer.name
   #   arn  = viewer.arn
    #}

}


output "ns-editor-iam" {
  value = {for k, v in aws_iam_role.  _ns_admin: k => v.name}
}


output "ns-admin-iam" {
  value = {for k, v in aws_iam_role.  _ns_admin: k => v.name}
}


output "ns-viewer-iam-test" {
  value = values(aws_iam_role.  _ns_viewer)[*].name
}


output "ns-editor-iam-test" {
  value = values(aws_iam_role.  _ns_editor)[*].name
}


output "ns-admin-iam-test" {
  value = values(aws_iam_role.  _ns_admin)[*].name
}




################################


