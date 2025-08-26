output "resource_group_name" {
  value = module.resource_group.name
}

# output "aks_name" {
#   value = module.aks.aks_name
# }

# output "storage_account_name" {
#   description = "Nome da conta de armazenamento"
#   value       = module.blob.storage_account_name
# }

# output "storage_container_name" {
#   description = "Nome do container"
#   value       = module.blob.storage_container_name
# }

# output "storage_account_connection_string" {
#   description = "Connection string primária da conta de armazenamento"
#   value       = module.blob.storage_account_connection_string
#   sensitive   = true
# }

output "acr_login_server" {
  description = "URL do login server do ACR"
  value       = module.acr.acr_login_server
}

output "acr_admin_username" {
  description = "Usuário admin do ACR"
  value       = module.acr.acr_admin_username
}

output "acr_admin_password" {
  description = "Senha admin do ACR"
  value       = module.acr.acr_admin_password
  sensitive   = true
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