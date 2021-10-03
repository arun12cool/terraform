output "privatelink_name" {
  value = aws_vpc_endpoint_service.customer_1.service_name
}

output "privatelink_state" {
  value = aws_vpc_endpoint_service.customer_1.state
}

output "privatelink_dns" {
  value = aws_vpc_endpoint_service.customer_1.base_endpoint_dns_names
}
