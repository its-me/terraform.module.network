terraform {
  required_version = ">= 1.7.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.20.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# The one stack that actually owns and creates the shared network. Every app
# consuming ../.. (the module root) with create = false reads these resources
# back instead of creating its own, so ownership lives here rather than in any
# individual app repo.
module "network" {
  source = "../.."

  project_id = var.project_id
  region     = var.region
  name       = var.name
  create     = true
}
