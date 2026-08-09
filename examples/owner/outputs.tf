output "network_id" {
  description = "ID of the shared VPC network."
  value       = module.network.network_id
}

output "network_name" {
  description = "Name of the shared VPC network."
  value       = module.network.network_name
}

output "subnet_id" {
  description = "ID of the shared subnet."
  value       = module.network.subnet_id
}

output "subnet_name" {
  description = "Name of the shared subnet."
  value       = module.network.subnet_name
}

output "vpc_connector_id" {
  description = "ID of the shared Serverless VPC Access connector."
  value       = module.network.vpc_connector_id
}
