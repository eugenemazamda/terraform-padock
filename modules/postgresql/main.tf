locals {
  ip_configuration_enabled = "${length(keys(var.ip_configuration)) > 0 ? true : false }"

  ip_configurations = {
    enabled = "${var.ip_configuration}"
    disabled = "${tomap({})}"
  }
}

resource "google_sql_database_instance" "instance" {
  project = "${var.project_id}"
  name = "${var.name}"
  database_version = "${var.database_version}"
  region = "${var.region}"

  settings {
    tier                        = "${var.project_id}"
    activation_policy           = "${var.activation_policy}"
    # ip_configuration            = ["${local.ip_configurations["${local.ip_configuration_enabled ? "enabled" : "disabled"}"]}"]

    disk_autoresize = "${var.disk_autoresize}"
    disk_size       = "${var.disk_size}"
    disk_type       = "${var.disk_type}"
    pricing_plan    = "${var.pricing_plan}"

    location_preference {
      zone = "${var.region}-${var.zone}"
    }
  }

  # lifecycle {
  #   ignore_changes = ["disk_size"]
  # }
}

resource "google_sql_database" "database" {
  name    = "${var.db_name}"
  project = "${var.project_id}"
  instance = "${google_sql_database_instance.instance.name}"
  depends_on = [
    "google_sql_database_instance.instance"
  ]
}

resource "random_id" "user-password" {
  keepers = {
    name = "${google_sql_database_instance.instance.name}"
  }

  byte_length = 8
  depends_on = [
    "google_sql_database_instance.instance"
  ]
}

resource "google_sql_user" "user_db" {
  name = "${var.user_name}"
  project = "${var.project_id}"
  instance = "${google_sql_database_instance.instance.name}"
  password = "${var.user_password == "" ? random_id.user-password.hex : var.user_password}"
  depends_on = [
    "google_sql_database_instance.instance"
  ]
}