# Commn
  variable "subscription_id" {
    type        = string
    description = "Azure Subscription ID"
  }
  variable "resource_group_name" {
    type    = string
    default = "tc3"
    description = "Nome do resource group"
  }
  # Assinatura Azure For Students não tem permissão para criar recursos em determinadas regiões
  # Ex: East US (https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits)
  variable "location" {
    type    = string
    default = "Central US" 
    description = "Localização do recurso"
  }
  variable "dns_prefix" {
    type = string
    description = "Prefixo DNS. Deve ser único globalmente."
    default = "foodcore"
    
    validation {
      condition     = length(var.dns_prefix) >= 1 && length(var.dns_prefix) <= 54
      error_message = "O 'dns_prefix' deve ter entre 1 e 54 caracteres."
    }
  }

# VNET
  variable "vnet_prefix" {
    description = "Prefixo de endereço da rede"
    type        = list(string)
    default     = ["10.0.0.0/16"]
  }

  variable "vnet_aks_service_subnet_prefix" {
    description = "Prefixo de endereço da subrede de serviço do AKS"
    type        = string
    default     = "10.0.0.0/24"
  }

  variable "vnet_aks_dns_service_ip" {
    description = "IP do serviço DNS do AKS"
    type        = string
    default     = "10.0.0.10"
  }

  variable "vnet_aks_subnet_prefix" {
    description = "Prefixo de endereço da subrede do AKS"
    type        = list(string)
    default     = ["10.0.1.0/24"]
  }

  variable "vnet_apim_subnet_prefix" {
    description = "Prefixo de endereço da subrede do APIM"
    type        = list(string)
    default     = ["10.0.2.0/24"]
  }

  variable "vnet_db_subnet_prefix" {
    description = "Prefixo de endereço da subrede do banco de dados"
    type        = list(string)
    default     = ["10.0.3.0/24"]
  }

# AKS
  variable "node_count" {
    type    = number
    default = 1
    description = "Número de nós no cluster AKS"
  }
  variable "vm_size" {
    type    = string
    default = "Standard_A4_v2"
    description = "Tamanho da VM para os nós do AKS"
  }
  variable "identity_type" {
    type = string
    default = "SystemAssigned"
    description = "Tipo de identidade do AKS."
  }
  variable "kubernetes_version" {
    type    = string
    default = "1.32.5"
    description = "Versão do Kubernetes a ser usada no AKS"
  }


# Blob Storage
  variable "container_name" {
    description = "Nome do container"
    type        = string
    default     = "images"
  }
  variable "account_tier" {
    description = "Nivel da conta de armazenamento"
    type        = string
    default     = "Standard"
  }
  variable "account_replication_type" {
    description = "Tipo de replicação da conta de armazenamento"
    type        = string
    default     = "LRS"
  }

# ACR
  variable "acr_sku" {
    description = "SKU do ACR"
    type        = string
    default     = "Basic"
  }
  variable "acr_admin_enabled" {
    description = "Habilita usuário admin"
    type        = bool
    default     = true
  }

# APIM

  variable "publisher_name" {
    description = "Nome do publicador do API Management"
    type        = string
    default     = "FoodCore"
  }

  variable "publisher_email" {
    description = "Email do publicador do API Management"
    type        = string
    default     = "RM364745@fiap.com.br"
  }

  variable "sku_name" {
    description = "SKU do API Management"
    type        = string
    default     = "Developer_1"
  }

  variable "apim_product_id" {
    description = "ID do produto do API Management"
    type        = string
    default     = "foodcoreapi_start"
  }

  variable "apim_product_display_name" {
    description = "Nome exibido do produto do API Management"
    type        = string
    default     = "FoodCore API Start"
  }

  variable "apim_product_description" {
    description = "Descrição do produto do API Management"
    type        = string
    default     = "Produto de API para o FoodCore"
  }

  variable "apim_subscription_display_name" {
    description = "Nome exibido da assinatura do API Management"
    type        = string
    default     = "FoodCore API Subscription"
  }

  variable "apim_subscription_state" {
    description = "Estado da assinatura do API Management"
    type        = string
    default     = "active"
  }