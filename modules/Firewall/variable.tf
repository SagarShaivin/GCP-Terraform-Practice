variable "firewall_name" {
  type = string
}

variable "target_vpc" {
  type = string
}

variable "protocol_type" {
  type = string
}

variable "allowed_ports" {
  type = list(string)
}

variable "allowed_iprange" {
  type = list(string)
}

variable "target_instances" {
  type = list(string)
}