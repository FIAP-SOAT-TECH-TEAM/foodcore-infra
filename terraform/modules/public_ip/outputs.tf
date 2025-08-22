output "fqdn" {
  value = azurerm_public_ip.ip.fqdn
}

output "ip_address" {
  value = azurerm_public_ip.ip.ip_address
}