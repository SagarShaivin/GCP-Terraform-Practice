variable "inst_name" {
  type = list(string)
}

variable "inst_type" {
  type = string
}

variable "zone_name" {
  type = list(string)
}

variable "image_type" {
  type = string
}

variable "no_of_inst" {
  type = number
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