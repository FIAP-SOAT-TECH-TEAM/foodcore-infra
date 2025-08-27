output "resource_group_name" {
  value = module.resource_group.name
}

output "aks_subnet_last_usable_ip" {
  description = "Último endereço IP utilizável da subnet do AKS (exclui o IP final reservado e broadcast)."
  value       = module.vnet.aks_subnet_last_usable_ip
}

output "aks_name" {
  value = module.aks.aks_name
}

output "aks_resource_group" {
  description = "Resource Group onde o cluster AKS reside"
  value       = module.aks.aks_resource_group
}

output "storage_container_name" {
  description = "Nome do container"
  value       = module.blob.storage_container_name
}

output "storage_account_connection_string" {
  description = "Connection string primária da conta de armazenamento"
  value       = module.blob.storage_account_connection_string
  sensitive   = true
}

output "acr_name" {
  description = "Nome do Azure Container Registry"
  value       = module.acr.acr_name
}

output "acr_resource_group" {
  description = "Resource Group do ACR"
  value       = module.acr.acr_resource_group
}

# output "apim_gateway_url" {
#   description = "URL do gateway do API Management"
#   value       = module.apim.apim_gateway_url
# }

# output "apim_management_api_url" {
#   description = "URL da API de gerenciamento do API Management"
#   value       = module.apim.apim_management_api_url
# }

# output "apim_public_ip_addresses" {
#   description = "Lista de IPs públicos do API Management"
#   value       = module.apim.apim_public_ip_addresses
# }