output "apim_gateway_url" {
  description = "URL do gateway do API Management"
  value       = azurerm_api_management.apim.gateway_url
}

output "apim_management_api_url" {
  description = "URL da API de gerenciamento do API Management"
  value       = azurerm_api_management.apim.management_api_url
}

output "apim_public_ip_addresses" {
  description = "Lista de IPs públicos do API Management"
  value       = azurerm_api_management.apim.public_ip_addresses
}