output "vm_public_ip" {
  description = "Public IP of the VM"
  value       = module.compute.public_ip
}

output "site_url" {
  description = "EpicBook site URL"
  value       = "http://${module.compute.public_ip}"
}

output "mysql_fqdn" {
  description = "MySQL server FQDN"
  value       = module.database.mysql_fqdn
  sensitive   = true
}

output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.main.name
}