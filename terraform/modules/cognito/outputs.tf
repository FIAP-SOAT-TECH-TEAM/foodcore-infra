output "cognito_user_pool_id" {
  description = "ID do Cognito User Pool"
  value       = aws_cognito_user_pool.cognito_user_pool.id
}

output "cognito_user_pool_client_id" {
  description = "ID do Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.foodcoreapp_cognito_client.id
}