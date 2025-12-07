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
  variable "aks_auto_scaling_enabled" {
    type        = bool
    description = "Habilita ou desabilita o auto scaling no pool de nós do AKS"
    
  }
  variable "aks_max_count" {
    type        = number
    description = "Número máximo de nós para auto scaling no pool de nós do AKS"
    
  }
  variable "aks_min_count" {
    type        = number
    description = "Número mínimo de nós para auto scaling no pool de nós do AKS"
    
  }
  variable "aks_availability_zones" {
    type        = list(string)
    description = "Zonas de disponibilidade para o pool de nós do AKS" 
  }
  variable "aks_network_plugin" {
    type        = string
    description = "Plugin de rede para o AKS" 
  }
  variable "aks_network_plugin_mode" {
    type        = string
    description = "Modo do plugin de rede. Somente válido quando network_plugin = azure"
    
    validation {
      condition = (
        var.aks_network_plugin == "azure" && var.aks_network_plugin_mode == "overlay" ||
        var.aks_network_plugin != "azure" && var.aks_network_plugin_mode == ""
      )
      error_message = "O modo 'overlay' só pode ser usado quando aks_network_plugin = 'azure'. Caso contrário, deixe aks_network_plugin_mode vazio."
    }
  }
  variable "aks_outbound_type" {
    type        = string
    description = "Tipo de saída de rede para o AKS" 
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

  variable "aks_node_subnet_id" {
    type = string
    description = "ID da sub-rede do AKS"
  }

  variable "aks_service_subnet_prefix" {
    description = "Prefixo de endereço da subrede de serviços do AKS"
    type        = string
  }

  variable "acr_id" {
    type = string
    description = "ID do Azure Container Registry"
  }
  variable "node_pool_name" {
    type        = string
    description = "Nome do pool de nós padrão do AKS"
    
    validation {
      condition     = length(var.node_pool_name) >= 1 && length(var.node_pool_name) <= 12
      error_message = "O 'node_pool_name' deve ter entre 1 e 12 caracteres."
    }
  }
  variable "node_pool_temp_name" {
    type        = string
    description = "Nome temporário para rotação do pool de nós do AKS"
    
    validation {
      condition     = length(var.node_pool_temp_name) >= 1 && length(var.node_pool_temp_name) <= 12
      error_message = "O 'node_pool_temp_name' deve ter entre 1 e 12 caracteres."
    }
  }

  variable "public_ip_resource_group_id" {
    type        = string
    description = "ID do resource group onde está o IP público do Ingress externo"
  }