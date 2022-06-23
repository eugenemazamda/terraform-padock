variable "region" {
  default = "us-central1"
}

variable "network" {
  default = "default"
}

variable "zone" {
  default = "us-central1-c"
}

variable "postgresql_version" {
  default = "POSTGRES_14"
}

# provider "google" {
#   region = "${var.region}"
# }

variable "network_name" {
  default = "psql-padok"
}

variable "project_id" {
  type  = string
  description  = "The Google cloud Project Id"
}