# Common
  variable "dns_prefix" {
    type = string
    description = "Prefixo DNS. Deve ser único globalmente."
    
    validation {
      condition     = length(var.dns_prefix) >= 1 && length(var.dns_prefix) <= 54
      error_message = "O 'dns_prefix' deve ter entre 1 e 54 caracteres."
    }
  }


variable "api_app_display_name" {
  description = "Nome do App Registration da API"
  type        = string
}

variable "auth_function_app_display_name" {
  description = "Nome do App Registration da Function App"
  type        = string
}

variable "admin_default_password" {
  description = "Senha padrão para o usuário admin criado no Azure AD"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.admin_default_password) >= 12
    error_message = "A senha padrão do admin deve ter pelo menos 12 caracteres."
  }
}