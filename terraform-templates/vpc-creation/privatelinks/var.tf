

variable "vpc_id" {
  description = "The ID of the VPC in which the endpoint will be used"
  default     = null
}

variable "vpc_name" {
  description = "A name for your VPC"
  default     = ""
}

variable "source_arn" {
  default = []
}


variable "tags" {
  description = "A map of key/value tags to assign to the resources."
  default     = {}
}

variable "instance_type" {
  description = "instance type"
  default     = ""
}

variable "instance_name" {
  description = "instance name"
  default     = ""
}

variable "target_group_name" {
  description = "TG name"
  default     = ""
}

variable "secgrp" {
  description = "to confirm if its customer or shared account"
  type    = bool
  default = false
}

variable "nlb_name" {
  description = "NLB name"
  default     = ""
}

variable "private_subnet_ids" {
  description = "Default subnets IDs to associate with the VPC endpoints"
  type        = list(string)
  default     = []
}

variable "sshkeypair" {
  description = "keypair for private link"
  default     = ""
}
