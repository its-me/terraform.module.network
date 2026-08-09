variable "project_id" {
  description = "GCP project ID the network lives in."
  type        = string
}

variable "region" {
  description = "GCP region for the subnet and VPC access connector."
  type        = string
}

variable "name" {
  description = "Name for the network, subnet, and VPC access connector. Every consuming app must be configured with this same name."
  type        = string
  default     = "tools"
}
