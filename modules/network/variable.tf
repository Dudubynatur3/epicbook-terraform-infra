variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "vnet_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "mysql_subnet_cidr" {
  type = string
}

variable "allowed_ip" {
  type = string
}

variable "tags" {
  type = map(string)
}