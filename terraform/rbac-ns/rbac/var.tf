

variable "namespace" {
  description = "name of the namespace"
  default     = ""

}

variable "annotations" {
  description = "Map of string key default pairs that can be used to store arbitrary metadata on the namespace and roles. See the Kubernetes Reference for more info (https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/)."
  type        = map(string)
  default     = {}

}

variable "labels" {
  description = "Map of string key default pairs that can be used to store arbitrary metadata on the namespace and roles. See the Kubernetes Reference for more info (https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/)."
  type        = map(string)
  default     = {}

}

variable "cluster_name" {
  description = "cluster name"
  default     = ""
}




variable "resource_ns_viewer" {}
variable "verbs_ns_viewer" {}

variable "resource_ns_editor1" {}
variable "verbs_ns_editor1" {}

variable "resource_ns_editor2" {}
variable "verbs_ns_editor2" {}

variable "resource_ns_editor3" {}
variable "verbs_ns_editor3" {}

variable "resource_ns_admin" {}
variable "verbs_ns_admin" {}


