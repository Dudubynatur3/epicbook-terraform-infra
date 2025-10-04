variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "mysql_subnet_id" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "db_admin_username" {
  type      = string
  sensitive = true
}

variable "db_admin_password" {
  type      = string
  sensitive = true
}

variable "tags" {
  type = map(string)
}