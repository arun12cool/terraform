variable "cluster_name" {
  description = "cluster name"
  default     = ""
}

### cluster wide ####

variable "resource_cluster_viewer" {}
variable "verbs_cluster_viewer" {}

variable "resource_cluster_editor1" {}
variable "verbs_cluster_editor1" {}

variable "resource_cluster_editor2" {}
variable "verbs_cluster_editor2" {}

variable "resource_cluster_editor3" {}
variable "verbs_cluster_editor3" {}

variable "resource_cluster_admin" {}
variable "verbs_cluster_admin" {}