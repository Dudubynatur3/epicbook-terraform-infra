variable "vnet_cidr" {
  description = "VNet CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "mysql_subnet_cidr" {
  description = "MySQL subnet CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

variable "db_admin_username" {
  description = "Database admin username"
  type        = string
  sensitive   = true
}

variable "db_admin_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "epicbook"
}

variable "vm_admin_username" {
  description = "VM admin username"
  type        = string
  default     = "azureuser"
}

variable "vm_admin_password" {
  description = "VM admin password"
  type        = string
  sensitive   = true
}