output "network_id" {
  description = "ID of the shared VPC network."
  value       = local.network_id
}

output "network_name" {
  description = "Name of the shared VPC network."
  value       = local.network_name
}

output "network_self_link" {
  description = "Self link of the shared VPC network."
  value       = local.network_self_link
}

output "subnet_id" {
  description = "ID of the shared subnet."
  value       = local.subnet_id
}

output "subnet_name" {
  description = "Name of the shared subnet."
  value       = local.subnet_name
}

output "vpc_connector_id" {
  description = "ID of the shared Serverless VPC Access connector, for use in Cloud Run vpc_access blocks."
  value       = local.vpc_connector_id
}
