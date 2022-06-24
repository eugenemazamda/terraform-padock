variable "project_id" {
  type  = string
  description  = "The Google cloud Project Id"
  default = "terraform-test-354115"
}

variable "region" {
  type   = string
  default   = "us-central1"
}

variable "zone" {
  description = "The zone for the master instance, it should be something like: `a`, `c`."
}

variable "name" {
  description = "The name of the cloud ssql resources"
}

variable "database_version" {
  description = "The database version to use"
}

variable "tier" {
  description = "The tier for the master instance."
  default     = "db-f1-micro"
}

variable "activation_policy" {
  description = "The activation policy for the master instance.Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`."
  default     = "ALWAYS"
}

variable "availability_type" {
  description = "The availability type for the master instance.This is only used to set up high availability for the PostgreSQL instance. Can be either `ZONAL` or `REGIONAL`."
  default     = "ZONAL"
}

variable "disk_autoresize" {
  description = "Configuration to increase storage size."
  default     = true
}

variable "disk_size" {
  description = "The disk size for the master instance."
  default     = 10
}

variable "disk_type" {
  description = "The disk type for the master instance."
  default     = "PD_SSD"
}

variable "pricing_plan" {
  description = "The pricing plan for the master instance."
  default     = "PER_USE"
}

variable "db_name" {
  description = "The name of the default database to create"
  default     = "db_padock"
}

variable "db_charset" {
  description = "The charset for the default database"
  default     = ""
}

variable "user_name" {
  description = "The name of the default user"
  default     = "eugene"
}

variable "user_password" {
  description = "The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable."
  default     = ""
}

variable "ip_configuration" {
  description = "The ip configuration for the master instances."

  default = {
    ipv4_enabled = "true"
  }
}

variable create_timeout {
  description = "The optional timout that is applied to limit long database creates."
  default     = "10m"
}

variable update_timeout {
  description = "The optional timout that is applied to limit long database updates."
  default     = "10m"
}

variable delete_timeout {
  description = "The optional timout that is applied to limit long database deletes."
  default     = "10m"
}