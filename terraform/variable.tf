variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "for-testing-432707"
}

variable "region" {
  description = "The region to deploy the database"
  type    = string
  default = "us-central1"
}

variable "zone" {
  description = "The region to deploy the database"
  type    = string
  default = "us-central1-a"
}
variable "vpc_name" {
  description = "The VPC name"
  type    = string
  default = "custom-vpc"
}

variable "vpc_subnet" {
  description = "The subnet name"
  type    = string
  default = "subnet-1"
}
variable "subnet_cidr_range" {
  description = "The subnet CIDR range"
  type    = string
  default = "10.0.0.0/24"
}
variable "subnet_vpc_connector_cidr_range" {
  description = "The subnet CIDR range for VPC connector"
  type    = string
  default = "10.8.0.0/28"
}
variable "db_instance_name" {
  description = "The name of the PostgreSQL database instance"
  type    = string
  default = "demo-db"
}

variable "db_name" {
  description = "The name of the PostgreSQL database"
  type    = string
  default = "test-db"
}

variable "db_user" {
  description = "The username for the PostgreSQL database"
  type    = string
  default = "dbuser"
}

variable "db_password" {
  description = "The password for the PostgreSQL database user"
  type    = string
  default = "postgres"
}

variable "disk_size" {
  description = "The disk size for PostgreSQL database instance"
  type    = string
  default = "10"
}

variable "disk_type" {
  description = "The disk type for PostgreSQL database instance"
  type    = string
  default = "PD_SSD"
}

variable "db_version" {
  description = "PostgreSQL version"
  default     = "POSTGRES_16"
}

variable "gcp_pg_tier" {
  type    = string
  default = "db-custom-4-16384"
}

variable "vm_instance_name" {
  description = "The name of the VM instance"
  type    = string
  default = "vm-linux"
}

variable "machine_type" {
  description = "The machine type for the VM instance"
  type    = string
  default = "e2-micro"
  
}

variable "docker_image" {
  description = "The Docker image to deploy"
  type        = string
  default     = "gcr.io/for-testing-432707/django-image:latest"
  
}
