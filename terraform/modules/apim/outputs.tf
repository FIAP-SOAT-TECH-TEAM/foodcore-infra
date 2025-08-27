output "apim_gateway_url" {
  description = "URL do gateway do API Management"
  value       = azurerm_api_management.apim.gateway_url
}