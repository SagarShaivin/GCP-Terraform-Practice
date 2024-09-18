variable "inst_name" {
  type = string
}

variable "inst_type" {
  type = string
}

variable "zone_name" {
  type = string
}

variable "image_type" {
  type = string
}

variable "tags" {
  type = list(string)
}

variable "ssh_user" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "vpc_network" {
  type = string
}

variable "vpc_subnetwork" {
  type = string
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP (true) or keep the instance private (false)"
  type        = bool
  default     = false
}

variable "static_ip" {
  type = string
}