resource "google_storage_bucket" "bucket" {
  name                        = var.bucket_name
  location                    = var.bucket_location
  storage_class               = var.bucket_storage_class
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access

  versioning {
    enabled = var.versioning
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = var.lifecycle_age
    }
  }
}

resource "google_storage_bucket_iam_member" "bucket_writer" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectAdmin" 
  member = var.bucket_writer_member
}

resource "google_storage_bucket_iam_member" "bucket_reader" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer" 
  member = var.bucket_reader_member
}
