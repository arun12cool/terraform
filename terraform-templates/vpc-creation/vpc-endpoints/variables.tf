variable "vpc_id" {
  description = "The ID of the VPC in which the endpoint will be used"
  default     = null
}

variable "endpoints" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  default     = {}
}

variable "security_group_ids" {
  description = "Default security group IDs to associate with the VPC endpoints"
  default     = ""
}

variable "subnet_ids" {
  description = "Default subnets IDs to associate with the VPC endpoints"
  type        = list(string)
  default     = []
}

variable "route_table_ids" {
  description = "Default route IDs to associate with the VPC endpoints"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of key/value tags to assign to the resources."
  default     = {}
}

variable "ssm-path" {
  description = "SSM Parameter path"
  default     = ""
}
