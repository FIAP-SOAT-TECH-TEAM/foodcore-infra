resource "aws_cognito_user_pool" "cognito_user_pool" {
  name = "${var.dns_prefix}_user_pool"

  schema {
    name               = "cpf"
    required           = false
    mutable            = false
    attribute_data_type = "String"
  }

  schema {
    name               = "guest"
    required           = true
    mutable            = false
    attribute_data_type = "Boolean"
  }

  schema {
    name               = "role"
    required           = true
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
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
  ]
  # Especifica quais acessos um aplicativo pode solicitar
  allowed_oauth_scopes = ["email", "openid"]
}