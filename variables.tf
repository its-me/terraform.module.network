variable "project_id" {
  description = "GCP project ID the network lives in."
  type        = string
}

variable "region" {
  description = "GCP region for the subnet and VPC access connector."
  type        = string
}

variable "name" {
  description = "Name for the network, subnet, and VPC access connector (e.g. \"tools\")."
  type        = string
}

variable "create" {
  description = "Whether this caller creates the network/subnet/connector (true), or just reads back resources created by another caller of this module in the same project (false). Exactly one caller sharing a given `name` should set this to true."
  type        = bool
  default     = true
}

variable "subnet_cidr" {
  description = "IPv4 CIDR range for the subnet. Only used when create = true."
  type        = string
  default     = "10.10.0.0/24"
}

variable "connector_cidr" {
  description = "IPv4 CIDR range for the Serverless VPC Access connector (must be a /28). Only used when create = true."
  type        = string
  default     = "10.10.1.0/28"
}

variable "private_service_range_prefix_length" {
  description = "Prefix length of the reserved internal range peered with servicenetworking.googleapis.com (Cloud SQL, Memorystore). Only used when create = true."
  type        = number
  default     = 20
}

variable "connector_machine_type" {
  description = "Machine type for the Serverless VPC Access connector's instances. Only used when create = true."
  type        = string
  default     = "e2-micro"
}

variable "connector_min_instances" {
  description = "Minimum number of instances for the VPC access connector (must be >= 2). Only used when create = true."
  type        = number
  default     = 2
}

variable "connector_max_instances" {
  description = "Maximum number of instances for the VPC access connector (must be > connector_min_instances). Only used when create = true."
  type        = number
  default     = 3
}
