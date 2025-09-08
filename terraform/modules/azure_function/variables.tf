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

variable "sa_account_tier" {
  description = "O nível da conta de armazenamento."
  type        = string
}

variable "sa_account_replication_type" {
  description = "O tipo de replicação da conta de armazenamento."
  type        = string
}

variable "az_func_sku_name" {
  description = "O nome do SKU do plano de serviço."
  type        = string
}

variable "az_func_os_type" {
  description = "O tipo de sistema operacional do plano de serviço."
  type        = string
}

variable "maximum_instance_count" {
  description = "O número máximo de instâncias para o plano de serviço."
  type        = number
}

variable "instance_memory_in_mb" {
  description = "A quantidade de memória (em MB) alocada para cada instância."
  type        = number
}

variable "azfunc_subnet_id" {
  description = "ID da subnet do Azure Functions"
  type        = string
}

variable "pe_subnet_id" {
  description = "ID da subnet do Private Endpoint"
  type        = string
}

variable "azfunc_private_dns_zone_id" {
  description = "ID da Private DNS Zone para o Azure Functions"
  type        = string
}

variable "azfunc_private_ip" {
  description = "Endereço IP privado para uso da aplicação hospedada no Azure Functions"
  type        = string
}