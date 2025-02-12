resource "google_cloud_run_v2_service" "django-service" {
  name     = "django-service"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [google_sql_database_instance.demo-postgres-db.connection_name]
      }
    }
    containers {
      image = var.docker_image
      ports {
        container_port = 8000
      }
      env {
        name = "DATABASE_URL"
        value = "postgres://${google_sql_user.db-user.name}:${var.db_password}@${google_sql_database_instance.demo-postgres-db.private_ip_address}:5432/${google_sql_database.default-db.name}"
      }
    }
    vpc_access{
      connector = google_vpc_access_connector.connector.id
      egress = "ALL_TRAFFIC"
    }
    timeout = "300s"
  }
  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
  
  depends_on = [ google_sql_database_instance.demo-postgres-db,
                 google_sql_database.default-db,
                 google_sql_user.db-user,
                 google_compute_network.custom-vpc,
                 google_compute_global_address.private-ip-allocation,
                  ]

}

# Allow Unauthenticated Access
resource "google_cloud_run_service_iam_member" "unauthenticated_access" {
  location    = google_cloud_run_v2_service.django-service.location
  service     = google_cloud_run_v2_service.django-service.name
  role        = "roles/run.invoker"
  member      = "allUsers" # This makes the service publicly accessible
}

output "cloud-run-name" {
  value = google_cloud_run_v2_service.django-service.name
}
output "cloud-run-url" {
  value = google_cloud_run_v2_service.django-service.uri
}


