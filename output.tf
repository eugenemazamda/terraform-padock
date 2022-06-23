output "psql_conn" {
  value = "${module.postgresql-db.instance_connection_name}"
}

output "psql_user_pass" {
  value = "${module.postgresql-db.generated_user_password}"
}