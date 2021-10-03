provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

### First Chart #####
resource "null_resource" "helm_test" {

  provisioner "local-exec" {
    command = <<-EOT
       helm repo add bitnami https://charts.bitnami.com/bitnami
     EOT
  }
}

resource "helm_release" "example" {
  name  = "redis"
  chart = "https://charts.bitnami.com/bitnami/redis-10.7.16.tgz"

  depends_on = [null_resource.helm_test]
}

output "chart_id1" {
  value = helm_release.example.chart
}

output "chart_name1" {
  value = helm_release.example.name
}

output "chart_status1" {
  value = helm_release.example.status
}

#### second chart ##### 

resource "null_resource" "helm_test1" {

  provisioner "local-exec" {
    command = <<-EOT
       helm create helm-demo-ms-app
     EOT
  }
  
}

resource "helm_release" "example1" {
  name       = "arun-chart"
  chart      = "helm-demo-ms-app"
  namespace  = "default"
  values     = ["${file("values.yaml")}"]

  depends_on = [null_resource.helm_test1]
}


output "chart_id" {
  value = helm_release.example1.chart
}

output "chart_name" {
  value = helm_release.example1.name
}

output "chart_status" {
  value = helm_release.example1.status
}

############


/*
Outputs:

chart_id = "helm-demo-ms-app"
chart_id1 = "https://charts.bitnami.com/bitnami/redis-10.7.16.tgz"
chart_name = "arun-chart"
chart_name1 = "redis"
chart_status = "deployed"
chart_status1 = "deployed"
*/