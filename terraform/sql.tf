resource "google_sql_database_instance" "demo-postgres-db" {
  name = var.db_instance_name
  database_version = var.db_version
  region = var.region
  project = var.project_id
  deletion_protection = false

  depends_on = [ google_compute_network.custom-vpc ,
                 google_compute_subnetwork.subnet-1,
                 google_compute_global_address.private-ip-allocation,
                 google_service_networking_connection.private_vpc_connection,
                 google_vpc_access_connector.connector
                 ]
  settings {
    edition = "ENTERPRISE"
    tier = var.gcp_pg_tier
    disk_size = var.disk_size
    disk_autoresize = true
    disk_type = var.disk_type
    availability_type = "ZONAL"

    backup_configuration {
        enabled = true
        point_in_time_recovery_enabled = true
    }
    ip_configuration {
      ipv4_enabled = false
      private_network = google_compute_network.custom-vpc.self_link
      enable_private_path_for_google_cloud_services = true
    }
  }
}

resource "google_sql_database" "default-db" {
  name = var.db_name
  instance = google_sql_database_instance.demo-postgres-db.name
  project = var.project_id
  depends_on = [ google_sql_database_instance.demo-postgres-db ]
}

resource "google_sql_user" "db-user" {
  name = var.db_user
  instance = google_sql_database_instance.demo-postgres-db.name
  password = var.db_password
  project = var.project_id
  depends_on = [ google_sql_database.default-db ]
}
