# Common
  variable "dns_prefix" {
    type = string
    description = "Prefixo DNS para a conta de armazenamento. Deve ser único globalmente."
    
    validation {
      condition     = length(var.dns_prefix) >= 1 && length(var.dns_prefix) <= 54
      error_message = "O 'dns_prefix' deve ter entre 1 e 54 caracteres."
    }
  }
  variable "resource_group_name" {
    type = string
    description = "Nome do resource group"
    
    validation {
      condition = can(regex("^[a-zA-Z0-9]+$", var.resource_group_name))
      error_message = "O nome do resource group deve conter apenas letras e números."
    }
  }
  variable "location" {
    description = "Localização do recurso"
    type = string
  }

# VNET
  variable "vnet_prefix" {
    description = "Prefixo de endereço da rede"
    type        = list(string)
  }

  variable "vnet_aks_subnet_prefix" {
    description = "Prefixo de endereço da subrede do AKS"
    type        = list(string)
  }

  variable "vnet_apim_subnet_prefix" {
    description = "Prefixo de endereço da subrede do APIM"
    type        = list(string)
  }

  variable "vnet_db_subnet_prefix" {
    description = "Prefixo de endereço da subrede do banco de dados"
    type        = list(string)
  }

  variable "vnet_pe_subnet_prefix" {
    description = "Prefixo de endereço da subrede do Private Endpoint"
    type        = list(string)
  }