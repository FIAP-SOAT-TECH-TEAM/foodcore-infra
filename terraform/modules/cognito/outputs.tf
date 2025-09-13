output "cognito_user_pool_id" {
  description = "ID do Cognito User Pool"
  value       = aws_cognito_user_pool.cognito_user_pool.id
}

output "cognito_user_pool_client_id" {
  description = "ID do Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.foodcoreapp_cognito_client.id
}

output "cognito_login_url" {
  description = "URL de login do Cognito User Pool"
  value = "https://${aws_cognito_user_pool_domain.cognito_user_pool_domain.domain}.auth.${var.aws_location}.amazoncognito.com/login?client_id=${aws_cognito_user_pool_client.foodcoreapp_cognito_client.id}&response_type=code&scope=email+openid&redirect_uri=${var.callback_urls[0]}"
}