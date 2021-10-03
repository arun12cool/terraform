module "namespaces" {

  source       = "../../../../modules/rbac"
  cluster_name = local.cluster_id

  namespace = {
    "${local.namespace1}" = { annotations = "${local.annotations1}", labels = "${local.labels1}", name = "${local.namespace1}" }
    "${local.namespace2}" = { annotations = "${local.annotations2}", labels = "${local.labels2}", name = "${local.namespace2}" }
    "${local.namespace3}" = { annotations = "${local.annotations3}", labels = "${local.labels3}", name = "${local.namespace3}" }
  }

  resource_ns_viewer = local.resource_ns_viewer
  verbs_ns_viewer    = local.verbs_ns_viewer

  resource_ns_editor1 = local.resource_ns_editor1
  verbs_ns_editor1    = local.verbs_ns_editor1

  resource_ns_editor2 = local.resource_ns_editor2
  verbs_ns_editor2    = local.verbs_ns_editor2

  resource_ns_editor3 = local.resource_ns_editor3
  verbs_ns_editor3    = local.verbs_ns_editor3

  resource_ns_admin = local.resource_ns_admin
  verbs_ns_admin    = local.verbs_ns_admin

 
}



####  Cluster wide : roles, role bindings and IAM mapping ###############
module "clusterwide-roles" {
  source               = "../../../../modules/rbac/clusterwide-roles"
  cluster_name = local.cluster_id

  resource_cluster_viewer = local.resource_cluster_viewer
  verbs_cluster_viewer    = local.verbs_cluster_viewer

  resource_cluster_editor1 = local.resource_cluster_editor1
  verbs_cluster_editor1    = local.verbs_cluster_editor1

  resource_cluster_editor2 = local.resource_cluster_editor2
  verbs_cluster_editor2    = local.verbs_cluster_editor2

  resource_cluster_editor3 = local.resource_cluster_editor3
  verbs_cluster_editor3    = local.verbs_cluster_editor3

  resource_cluster_admin = local.resource_cluster_admin
  verbs_cluster_admin    = local.verbs_cluster_admin
  
}