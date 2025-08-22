output "aks_subnet" {
  description = "Subnet criada para o cluster AKS."
  value       = azurerm_subnet.aks_subnet
}

output "apim_subnet" {
  description = "Subnet criada para o serviço Azure API Management."
  value       = azurerm_subnet.apim_subnet
}