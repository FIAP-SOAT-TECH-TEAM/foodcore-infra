output "azfunc_name" {
  description = "O nome da Azure Function App"
  value       = azurerm_function_app_flex_consumption.azfunc.name
}