# Common
  variable "dns_prefix" {
    type = string
    description = "Prefixo DNS. Deve ser único globalmente."
    
    validation {
      condition     = length(var.dns_prefix) >= 1 && length(var.dns_prefix) <= 54
      error_message = "O 'dns_prefix' deve ter entre 1 e 54 caracteres."
    }
  }

variable "default_customer_password" {
  type        = string
  description = "Senha padrão para o usuário cliente."
  
  validation {
    condition     = length(var.default_customer_password) >= 8
    error_message = "A 'default_customer_password' deve ter pelo menos 8 caracteres."
  }
}