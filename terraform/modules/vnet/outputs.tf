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

output "api_private_dns_fqdn" {
  description = "FQDN do registro A da API na zona DNS privada"
  value       = "${azurerm_private_dns_a_record.api_dns_a.name}.${azurerm_private_dns_a_record.api_dns_a.zone_name}"
}