output "mysql_fqdn" {
  value = azurerm_mysql_flexible_server.main.fqdn
}

output "mysql_server_name" {
  value = azurerm_mysql_flexible_server.main.name
}