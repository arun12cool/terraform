#########VPC########################

variable "vpc_cidr" {
  description = "vpc_cidr block"
  default     = ""
}

variable "Region" {
  description = "region"
  default     = "us-west-2"
}

variable "vpc_cidr_public" {
  description = "vpc_cidr block"
  default     = ""
}

variable "vpc_name" {
  description = "A name for your VPC"
  default     = ""
}

variable "vpc_tenancy" {
  default = "default"
}

variable "zone_id" {
  default = ""
}



variable "customer" {
  description = "to confirm if its customer or shared account"
  type    = bool
  default = false
}

######SUBNET#################################
variable "subnet_cidr_priv" {
  // type = list
  default = ""
}


variable "subnet_cidr_pub" {
  // type = list
  default = ""
}

variable "az_list_priv" {
  default = ""
}


variable "az_list_pub" {
  default = ""
}


variable "local_newbits_priv" {
  default = ""
}

variable "local_newbits_pub" {
  default = ""
}


variable "private_subnets_allow_https" {
  description = "Set to true to allow HTTPS in the private NACL rule set."
  default     = false
}


variable "public_subnets_allow_https" {
  description = "Set to true to allow HTTPS in the public NACL rule set."
  default     = false
}

variable "public_subnets_allow_vpn" {
  description = "Set to true to allow VPN in the public NACL rule set."
  default     = false
}

###############ROUTE 53 ###############################

variable "enable_route53" {
  description = "Toggles creation of a route53 zone"
  default     = "false"
}


variable "zone_name" {
  description = "name for your route53 private hosted zone"
  default     = ""
}



#########TAGS ##########################


variable "App" {
  default = ""
}

variable "AppOwner" {
  default = ""
}
variable "Environment" {
  default = ""
}
variable "Contact" {
  default = ""
}
variable "Name" {
  default = ""
}

variable "AppComponent" {
  default = ""
}
variable "Creator" {
  default = ""
}
variable "CostCenter" {
  default = ""
}
variable "Customer" {
  default = ""
}
variable "Location" {
  default = ""
}
variable "Memo" {
  default = ""
}
variable "IAAS_NAME" {
  default = ""
}
variable "IAAS_NIC_NAME" {
  default = ""
}
#########################################


variable "ssm-path" {
  description = "Path for your SSM"
  default     = ""
}

variable "source_arn" {
  default = []
}

variable "instance_type" {
  description = "instance type"
  default     = ""
}

variable "instance_name" {
  description = "instance name"
  default     = ""
}

variable "sshkeypair" {
  description = "keypair for private link"
  default     = ""
}