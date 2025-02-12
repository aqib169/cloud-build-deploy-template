resource "google_compute_network" "custom-vpc" {
    name = var.vpc_name
    auto_create_subnetworks = false
  
}

resource "google_compute_subnetwork" "subnet-1" {
    name = var.vpc_subnet
    ip_cidr_range = var.subnet_cidr_range
    network = google_compute_network.custom-vpc.id
    region = var.region
    private_ip_google_access = true
}

resource "google_compute_global_address" "private-ip-allocation" {
    provider = google-beta

    name = "ip-range-db"
    purpose = "VPC_PEERING"
    address_type = "INTERNAL"
    prefix_length = 16
    network = google_compute_network.custom-vpc.id

}
resource "google_project_service" "service_networking" {
  project = var.project_id
  service = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = google_compute_network.custom-vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private-ip-allocation.name]
  deletion_policy = "ABANDON"
  lifecycle {
    ignore_changes = [reserved_peering_ranges]
  }
}

resource "google_vpc_access_connector" "connector" {
  name          = "run-vpc"
  region        = var.region
  network       = google_compute_network.custom-vpc.id
  ip_cidr_range = var.subnet_vpc_connector_cidr_range
  machine_type  = "e2-standard-4"
  min_instances = 2
  max_instances = 3

  depends_on = [ google_compute_network.custom-vpc,google_project_service.service_networking,google_service_networking_connection.private_vpc_connection ]
}