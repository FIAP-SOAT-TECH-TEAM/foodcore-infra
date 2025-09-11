resource "aws_cognito_user_pool" "cognito_user_pool" {
  name = "${var.dns_prefix}_user_pool"

  schema {
    name               = "cpf"
    required           = false
    mutable            = false
    attribute_data_type = "String"
  }

  schema {
    name               = "role"
    required           = false # https://github.com/hashicorp/terraform-provider-aws/issues/18430
    mutable            = true
    attribute_data_type = "String"
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  admin_create_user_config {
    allow_admin_create_user_only = true
  }
}

# Representa a “aplicação” que vai se autenticar ou usar o pool de usuários
resource "aws_cognito_user_pool_client" "azfunc_auth_cognito_client" {
  name            = "${var.dns_prefix}_user_pool_client"
  user_pool_id    = aws_cognito_user_pool.cognito_user_pool.id
  generate_secret = false

  allowed_oauth_flows_user_pool_client = true

  # Define a forma como o aplicativo irá obter o token após a autenticação
  allowed_oauth_flows                  = ["code", "implicit"]

  # Especifica quais informações um aplicativo terá acesso após obter um token
  allowed_oauth_scopes                 = ["email", "openid"]

  # Define os fluxos de autenticação permitidos para que o aplicativo consiga obter um token
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
  ]

}

resource "aws_cognito_user" "guest_customer" {
  user_pool_id = aws_cognito_user_pool.cognito_user_pool.id
  username     = "guest_customer"

  attributes = {
    email = "guest@${var.dns_prefix}.com"
    name  = "Guest User"
    role  = "CUSTOMER"
  }

  password = var.default_customer_password

  force_alias_creation = false
  message_action       = "SUPPRESS"
}