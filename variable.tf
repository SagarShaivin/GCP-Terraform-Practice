variable "triage_1_terraform_key" {
  type = string
  sensitive = true
}

variable "gcp_project_id" {
  type = string
}

variable "ssh_user" {
  type = string
}

variable "ssh_public_key" {
  type = string
}