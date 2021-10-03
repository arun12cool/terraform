### VPC ######

output "subnet_priv" {
  value = module.subnet_addrs_main_cidr_priv.networks[*].cidr_block
}

output "subnet_pub" {
  value = module.subnet_addrs_main_cidr_pub.networks[*].cidr_block
}  
  
output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "public_route_table" {
  value = aws_route_table.public.id
}

output "private_route_table" {
  value = aws_route_table.private[*].id
}

output "eip" {
  value = aws_eip.nat[*].public_ip
}


output "nat_gateway" {
  value = aws_nat_gateway.ngw[*].id
}

output "internet_gateway" {
  value = aws_internet_gateway.igw.id
}

output "vpc_id" {
  value = aws_vpc.base.id
}
  
output "security_group_id" {
  value = aws_security_group.secgrp_1.id
}
  
output "policy_1" {
  value = data.aws_iam_policy_document.policy_1.json
}
  
  ## Private Links ####
  
output "privatelink" {
  value = module.private_link_customer[*].privatelink_name
}    

output "privatelink_dnsnames" {
  value = module.private_link_customer[*].privatelink_dns
} 

output "privatelink_status" {
  value = module.private_link_customer[*].privatelink_state
} 

  
  ### VPC ENDPOINTS Customer accounts#######
  
 output "endpoint_vpc" {
  value = var.customer == true ? module.vpc_endpoints_customer[*].endpoints : module.vpc_endpoints_shared[*].endpoints
} 

 output "endpoint_id" {
  value = var.customer == true ? module.vpc_endpoints_customer[*].endpoints_id : module.vpc_endpoints_shared[*].endpoints_id
} 

 output "endpoint_dns" {
  value = var.customer == true ? module.vpc_endpoints_customer[*].endpoints_dns : module.vpc_endpoints_shared[*].endpoints_dns
} 
    
output "ssm" {
  value = var.customer == true ? module.vpc_endpoints_customer[*].ssm_parameter : module.vpc_endpoints_shared[*].ssm_parameter
}  

output "ssm_id" {
  value = var.customer == true ? module.vpc_endpoints_customer[*].ssm_parameter_id : module.vpc_endpoints_shared[*].ssm_parameter_id
}  
    
 
  
