###############################################################
############ cluster super admin #################
data "aws_iam_role" "    _cluster_admin" {
  name = aws_iam_role.    _cluster_admin.name
}


resource "null_resource" "    _cluster_admin" {

  provisioner "local-exec" {
    command = <<-EOT
       eksctl create iamidentitymapping --cluster ${var.cluster_name} --arn ${data.aws_iam_role.    _cluster_admin.arn} --group ${local.    _cluster_admin}
       sleep 10
     EOT
  }
}


############## cluster editor #####################
data "aws_iam_role" "    _cluster_editor" {
  name = aws_iam_role.    _cluster_editor.name
}


resource "null_resource" "    _cluster_editor" {

  provisioner "local-exec" {
    command = <<-EOT
       eksctl create iamidentitymapping --cluster ${var.cluster_name} --arn ${data.aws_iam_role.    _cluster_editor.arn} --group ${local.    _cluster_editor}
       sleep 10
     EOT
  }
  depends_on = [null_resource.    _cluster_admin]
}


######### Cluster admin view ########################
data "aws_iam_role" "    _cluster_viewer" {
  name = aws_iam_role.    _cluster_viewer.name
}

resource "null_resource" "    _cluster_viewer" {
  /*triggers = {
    always_run = timestamp()
  }*/
  provisioner "local-exec" {
    command = <<-EOT
       eksctl create iamidentitymapping --cluster ${var.cluster_name} --arn ${data.aws_iam_role.    _cluster_viewer.arn} --group ${local.    _cluster_viewer}
       sleep 10
     EOT
  }
  depends_on = [null_resource.    _cluster_editor]
}





