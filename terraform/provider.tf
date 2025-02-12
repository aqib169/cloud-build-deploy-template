terraform {
    required_providers {
        google = {
        source  = "hashicorp/google"
        version = "~> 5"
        }
        google-beta = {
        source  = "hashicorp/google-beta"
        version = "~> 5"
        }
    }
}

provider "google" {
    project = var.project_id
    region = var.region
    zone = var.zone
}
provider "google-beta" {
    project = var.project_id
    region = var.region
    zone = var.zone
  
}