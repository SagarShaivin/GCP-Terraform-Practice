resource "google_sql_database_instance" "instance" {
  name             = var.db_instance_name
  region           = var.region_name
  database_version = var.db_version
  settings {
    tier = var.db_tier
  }

  deletion_protection  = var.deletion_protection
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.instance.name
}