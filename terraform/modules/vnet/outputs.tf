output "aks_subnet_last_usable_ip" {
  description = "Último endereço IP utilizável da subnet do AKS (exclui o IP final reservado e broadcast)."
  value       = cidrhost(azurerm_subnet.aks_subnet.address_prefixes[0], -2)
}

output "aks_subnet" {
  description = "Subnet do AKS"
  value = azurerm_subnet.aks_subnet
}

output "apim_subnet" {
  description = "Subnet do APIM"
  value = azurerm_subnet.apim_subnet
}