output "ssm_parameter" {
  value = aws_ssm_parameter.endpoint
}
output "ssm_parameter_arn" {
  value = values(aws_ssm_parameter.endpoint)[*].arn  
}
output "ssm_parameter_id" {
  value = values(aws_ssm_parameter.endpoint)[*].id
}

output "endpoints" {
  description = "Array containing the full resource object and attributes for all endpoints created"
  value       = aws_vpc_endpoint.endpoint
}
output "endpoints_id" {
  description = "Array containing the full resource object and attributes for all endpoints created"
  value       = values(aws_vpc_endpoint.endpoint)[*].id 
}
output "endpoints_dns" {
  description = "Array containing the full resource object and attributes for all endpoints created"
  value       = values(aws_vpc_endpoint.endpoint)[*].dns_entry[*]["dns_name"]
}
