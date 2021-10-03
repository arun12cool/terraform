############# Viewer ############################
data "aws_iam_role" "   _ns_viewer" {
  for_each = var.namespace
  name     = aws_iam_role.   _ns_viewer[each.key].name
}


resource "null_resource" "   _ns_viewer" {
  /*triggers = {
    always_run = timestamp()
  }*/
  for_each = var.namespace

  provisioner "local-exec" {
    command = <<-EOT
       eksctl create iamidentitymapping --cluster ${var.cluster_name} --arn ${data.aws_iam_role.   _ns_viewer[each.key].arn} --group "${each.key}-${local.   _ns_viewer}"
       sleep 10
     EOT
  }
  depends_on = [kubernetes_namespace.k8s-namespace]
}


###################### Editor ##################

data "aws_iam_role" "   _ns_editor" {
  for_each = var.namespace
  name     = aws_iam_role.   _ns_editor[each.key].name
}

resource "null_resource" "   _ns_editor" {
 /* triggers = {
    always_run = timestamp()
  }*/
  for_each = var.namespace

  provisioner "local-exec" {
    command = <<-EOT
       eksctl create iamidentitymapping --cluster ${var.cluster_name} --arn ${data.aws_iam_role.   _ns_editor[each.key].arn} --group "${each.key}-${local.   _ns_editor}"
       sleep 10
     EOT
  }
  depends_on = [null_resource.   _ns_viewer, kubernetes_namespace.k8s-namespace]
}


################ Admin ##########################
data "aws_iam_role" "   _ns_admin" {
  for_each = var.namespace
  name     = aws_iam_role.   _ns_admin[each.key].name
}


resource "null_resource" "   _ns_admin" {
  /*triggers = {
    always_run = timestamp()
  }*/
  for_each = var.namespace

  provisioner "local-exec" {
    command = <<-EOT
       eksctl create iamidentitymapping --cluster ${var.cluster_name} --arn ${data.aws_iam_role.   _ns_admin[each.key].arn} --group "${each.key}-${local.   _ns_admin}"
       sleep 10
     EOT
  }
  depends_on = [null_resource.   _ns_editor, null_resource.   _ns_viewer, kubernetes_namespace.k8s-namespace]
}


###################################################
