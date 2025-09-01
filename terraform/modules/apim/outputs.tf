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

output "apim_foodcore_start_productid" {
  description = "ID do produto do API Management"
  value       = azurerm_api_management_product.foodcoreapi_start_product.id
}

output "apim_foodcore_start_subscriptionid" {
  description = "ID da assinatura do API Management"
  value       = azurerm_api_management_subscription.foodcoreapi_start_subscription.id
}