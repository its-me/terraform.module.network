# One caller (create = true) provisions the network, subnet, private-service
# peering, and VPC connector. Every other caller sharing the same `name` in the
# same project (create = false) just reads them back via data sources, so that
# multiple independently-applied configs can sit on one shared VPC without
# fighting over who owns it.

resource "google_compute_network" "this" {
  count = var.create ? 1 : 0

  name                    = var.name
  project                 = var.project_id
  auto_create_subnetworks = false
}

data "google_compute_network" "this" {
  count = var.create ? 0 : 1

  name    = var.name
  project = var.project_id
}

locals {
  network_id        = var.create ? google_compute_network.this[0].id : data.google_compute_network.this[0].id
  network_name      = var.create ? google_compute_network.this[0].name : data.google_compute_network.this[0].name
  network_self_link = var.create ? google_compute_network.this[0].self_link : data.google_compute_network.this[0].self_link
}

resource "google_compute_subnetwork" "this" {
  count = var.create ? 1 : 0

  name          = var.name
  project       = var.project_id
  region        = var.region
  network       = local.network_id
  ip_cidr_range = var.subnet_cidr
}

data "google_compute_subnetwork" "this" {
  count = var.create ? 0 : 1

  name    = var.name
  project = var.project_id
  region  = var.region
}

locals {
  subnet_id   = var.create ? google_compute_subnetwork.this[0].id : data.google_compute_subnetwork.this[0].id
  subnet_name = var.create ? google_compute_subnetwork.this[0].name : data.google_compute_subnetwork.this[0].name
}

# Reserved range + peering so Cloud SQL and Memorystore get private IPs on this VPC.
resource "google_compute_global_address" "private_service_range" {
  count = var.create ? 1 : 0

  name          = "${var.name}-private-service-range"
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = var.private_service_range_prefix_length
  network       = local.network_id
}

resource "google_service_networking_connection" "private_service_connection" {
  count = var.create ? 1 : 0

  network                 = local.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_service_range[0].name]
}

# Lets Cloud Run reach the private VPC (Cloud SQL, Memorystore).
resource "google_vpc_access_connector" "this" {
  count = var.create ? 1 : 0

  name          = var.name
  project       = var.project_id
  region        = var.region
  network       = local.network_name
  ip_cidr_range = var.connector_cidr
}

data "google_vpc_access_connector" "this" {
  count = var.create ? 0 : 1

  name    = var.name
  project = var.project_id
  region  = var.region
}

locals {
  vpc_connector_id = var.create ? google_vpc_access_connector.this[0].id : data.google_vpc_access_connector.this[0].id
}
