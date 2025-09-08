output "aks_api_private_ip" {
  description = "Endereço IP privado para uso da aplicação hospedada no AKS"
  value       = local.aks_api_private_ip
}

output "azfunc_private_ip" {
  description = "Endereço IP privado para uso da aplicação hospedada no Azure Functions"
  value       = local.azfunc_private_ip
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

output "azfunc_private_dns_fqdn" {
  description = "FQDN do registro A do Azure Functions na zona DNS privada"
  value       = "${azurerm_private_dns_a_record.azfunc_dns_a.name}.${azurerm_private_dns_a_record.azfunc_dns_a.zone_name}"
}

output "db_subnet_id" {
  description = "ID da subnet do banco de dados"
  value       = azurerm_subnet.db_subnet.id
}

output "azfunc_subnet_id" {
  description = "ID da subnet do Azure Functions"
  value       = azurerm_subnet.azfunc_subnet.id
}

output "pe_subnet_id" {
  description = "ID da subnet de Private Endpoint"
  value       = azurerm_subnet.pe_subnet.id
}

output "pgsql_private_dns_zone_id" {
  description = "ID da zona DNS privada do PostgreSQL"
  value       = azurerm_private_dns_zone.postgres_private_dns.id
}

output "azfunc_private_dns_zone_id" {
  description = "ID da zona DNS privada do Azure Functions"
  value       = azurerm_private_dns_zone.azfunc_private_dns.id
}