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

# AKS
  variable "node_count" {
    type    = number
    description = "Número de nós no cluster AKS"

    validation {
      condition     = var.node_count >= 1 && var.node_count <= 5
      error_message = "O 'node_count' deve ser um número entre 1 e 5."
    }
  }
  variable "vm_size" {
    type    = string
    description = "Tamanho da VM para os nós do AKS"
  }
  variable "identity_type" {
    type = string
    description = "Tipo de identidade do AKS."
  }
  variable "kubernetes_version" {
    type    = string
    description = "Versão do Kubernetes a ser usada no AKS"
  }

  variable "aks_subnet_id" {
    type = string
    description = "ID da sub-rede do AKS"
  }

  variable "aks_service_cidr" {
    type = string
    description = "CIDR para o serviço AKS"
  }

  variable "aks_dns_service_ip" {
    type = string
    description = "IP do serviço DNS do AKS"
  }

  variable "acr_id" {
    type = string
    description = "ID do Azure Container Registry"
  }