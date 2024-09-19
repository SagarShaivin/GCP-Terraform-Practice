variable "bucket_name" {
  type        = string
}

variable "bucket_location" {
  type        = string
  default     = "US" # Default location is set to "US"
}

variable "bucket_storage_class" {
  type        = string
  default     = "STANDARD" # Default storage class
}

variable "force_destroy" {
  type        = bool
  default     = false
}

variable "uniform_bucket_level_access" {
  type        = bool
  default     = true
}

variable "versioning" {
  type        = bool
  default     = false
}

variable "lifecycle_age" {
  type        = number
  default     = 365
}

variable "bucket_writer_member" {
  type        = string
}

variable "bucket_reader_member" {
  type        = string
}