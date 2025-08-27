output "apim_gateway_url" {
  description = "URL do gateway do API Management"
  value       = azurerm_api_management.apim.gateway_url
}

output "apim_resource_group" {
  description = "Resource Group do API Management"
  value       = azurerm_api_management.apim.resource_group_name
}

output "apim_name" {
  description = "Nome do API Management"
  value       = azurerm_api_management.apim.name
}