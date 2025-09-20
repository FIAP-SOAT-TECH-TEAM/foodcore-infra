#Common
  output "resource_group_name" {
    value = module.resource_group.name
  }

  output "location" {
    value = var.location
  }

  output "aws_location" {
    value = var.aws_location
  }

  output "dns_prefix" {
    value = var.dns_prefix
  }

# AKS
  output "aks_api_private_ip" {
    description = "Endereço IP privado para uso da aplicação hospedada no AKS"
    value       = module.vnet.aks_api_private_ip
  }

  output "aks_name" {
    value = module.aks.aks_name
  }

  output "aks_resource_group" {
    description = "Resource Group onde o cluster AKS reside"
    value       = module.aks.aks_resource_group
  }

# Blob

  output "storage_container_name" {
    description = "Nome do container"
    value       = module.blob.storage_container_name
  }

  output "storage_account_connection_string" {
    description = "Connection string primária da conta de armazenamento"
    value       = module.blob.storage_account_connection_string
    sensitive   = true
  }

# ACR

  output "acr_name" {
    description = "Nome do Azure Container Registry"
    value       = module.acr.acr_name
  }

  output "acr_resource_group" {
    description = "Resource Group do ACR"
    value       = module.acr.acr_resource_group
  }

# APIM

  output "apim_gateway_url" {
    description = "URL do gateway do API Management"
    value       = module.apim.apim_gateway_url
  }

  output "apim_resource_group" {
    description = "Resource Group do API Management"
    value       = module.apim.apim_resource_group
  }

  output "apim_name" {
    description = "Nome do API Management"
    value       = module.apim.apim_name
  }

  output "apim_foodcore_start_productid" {
    description = "ID do produto do API Management"
    value       = module.apim.apim_foodcore_start_productid
  }

  output "apim_foodcore_start_subscriptionid" {
    description = "ID da assinatura do API Management"
    value       = module.apim.apim_foodcore_start_subscriptionid
    sensitive   = true
  }

# VNET
  output "api_private_dns_fqdn" {
    description = "FQDN do registro A da API na zona DNS privada"
    value       = module.vnet.api_private_dns_fqdn
  }

  output "db_subnet_id" {
    description = "ID da subnet do banco de dados"
    value       = module.vnet.db_subnet_id
  }

  output "pgsql_private_dns_zone_id" {
    description = "ID da zona DNS privada do PostgreSQL"
    value       = module.vnet.pgsql_private_dns_zone_id
  }

  output "vnet_aks_subnet_prefix" {
    description = "Prefixo de endereço da subrede do AKS"
    value       = var.vnet_aks_subnet_prefix
  }

# Cognito

  output "cognito_user_pool_id" {
    description = "ID do Cognito User Pool"
    value       = module.cognito.cognito_user_pool_id
  }

  output "cognito_user_pool_client_id" {
    description = "ID do Cognito User Pool Client"
    value       = module.cognito.cognito_user_pool_client_id
  }

  output "default_customer_password" {
    description = "Senha padrão do usuário cliente"
    value       = var.default_customer_password
    sensitive   = true
  }

  output "cognito_code_login_url" {
    description = "URL de login do Cognito User Pool (usando o fluxo de authorization code)"
    value       = module.cognito.cognito_code_login_url
  }

  output "cognito_code_get_token_url" {
    description = "URL para obtenção do token do Cognito User Pool (usando o fluxo de authorization code)"
    value       = module.cognito.cognito_code_get_token_url
  }

  output "cognito_implicit_login_url" {
    description = "URL de login do Cognito User Pool (usando o fluxo implícito)"
    value       = module.cognito.cognito_implicit_login_url
  }

  output "guest_user_email" {
    description = "Email do usuário convidado (guest)"
    value       = module.cognito.guest_user_email
  }

# Azure Function
  output "azfunc_name" {
    description = "O nome da Azure Function App"
    value       = module.azfunc.azfunc_name
  }

  output "azfunc_private_dns_fqdn" {
    description = "FQDN do registro A do Azure Functions na zona DNS privada"
    value       = module.vnet.azfunc_private_dns_fqdn
  }