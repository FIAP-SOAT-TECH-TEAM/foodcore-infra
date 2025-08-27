# Common
  variable "dns_prefix" {
    type = string
    description = "Prefixo DNS. Deve ser único globalmente."
    
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

# APIM

  variable "apim_subnet_id" {
    type = string
    description = "ID da sub-rede do APIM"
  }

  variable "publisher_name" {
    description = "Nome do publicador do API Management"
    type        = string
  }

  variable "publisher_email" {
    description = "Email do publicador do API Management"
    type        = string
  }

  variable "sku_name" {
    description = "SKU do API Management"
    type        = string
  }

