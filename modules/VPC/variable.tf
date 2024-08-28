variable "network_name" {
  type = string
}

variable "subnet_name" {
  type = list(string)
}

variable "subnet_iprange" {
  type = list(string)
}

variable "region_name" {
  type = list(string)
}

variable "no_of_subnets" {
  type = number
}

