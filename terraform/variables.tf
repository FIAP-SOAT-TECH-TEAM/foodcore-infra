# Commn
  variable "subscription_id" {
    type        = string
    description = "Azure Subscription ID"
    # Default (Via tfvars)
  }
  variable "resource_group_name" {
    type    = string
    default = "tc2"
    description = "Nome do resource group"
  }
  variable "location" {
    type    = string
    default = "East US"
    description = "Localização do recurso"
  }
  variable "dns_prefix" {
    type = string
    description = "Prefixo DNS. Deve ser único globalmente."
    default = "foodcoreapi2"
    
    validation {
      condition     = length(var.dns_prefix) >= 1 && length(var.dns_prefix) <= 54
      error_message = "O 'dns_prefix' deve ter entre 1 e 54 caracteres."
    }
  }

# Public IP
  variable "allocation_method" {
    type    = string
    default = "Static"
    description = "Método de alocação do IP público"
  }
  variable "sku" {
    type    = string
    default = "Standard"
    description = "SKU do IP público"
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