# data "google_client_config" "current" {}

resource "google_compute_network" "network" {
  project     = "${var.project_id}"
  name        = "${var.network_name}"
  autauto_create_subnetworks = false 
}

resource "google_compute_subnetwork" "subnet" {
  project = "${var.project_id}"
  name = "${var.network_name}"
  ip_cidr_range = "10.127.0.0/20"
  network = "${google_compute_network.network.self_link}"
  region = "${var.region}"
  private_ip_google_access = true
}

resource "random_id" "name" {
    byte_length = 2
}

module "postgresql-db" {
  source = "/modules/postgresql"
  name   = "padock-postgresql-${random_id.name.hex}"
  database_version = "${var.postgresql_version}"
  project_id   = "${var.project_id}"

  ip_configuration = [{
    ipv4_enabled = true

    authorized_networks = [{
      name  = "${var.network_name}"
      value = "${google_compute_subnetwork.network.ip_cidr_range}"
    }]
  }]
}