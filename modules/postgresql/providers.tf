provider "google" {
  project = var.project_id
  region = var.region
}

terraform {
  backend "gcs" {
    bucket = "terraformtestpadock1"
    prefix = "terraform/state-m"
  }
}