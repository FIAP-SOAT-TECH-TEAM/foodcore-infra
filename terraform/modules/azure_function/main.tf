resource "azurerm_storage_account" "azfunc-sa" {
  name                     = "${var.dns_prefix}azfuncsa"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.sa_account_tier
  account_replication_type = var.sa_account_replication_type
}

resource "azurerm_storage_container" "azfunc-sa-container" {
  name                  = "${var.dns_prefix}-azfunc-sa-container"
  storage_account_id    = azurerm_storage_account.azfunc-sa.id
  container_access_type = "private"
}

resource "azurerm_application_insights" "azfunc-app-insights" {
  name                = "${var.dns_prefix}-azfunc-app-insights"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

resource "azurerm_service_plan" "azfunc-service-plan" {
  name                = "${var.dns_prefix}-azfunc-service-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.az_func_sku_name
  os_type             = var.az_func_os_type
}

# https://github.com/hashicorp/terraform-provider-azurerm/pull/28199
resource "azurerm_function_app_flex_consumption" "azfunc" {
  name                          = "${var.dns_prefix}-azfunc"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  service_plan_id               = azurerm_service_plan.azfunc-service-plan.id
  storage_container_type        = "blobContainer"
  storage_container_endpoint    = "${azurerm_storage_account.azfunc-sa.primary_blob_endpoint}${azurerm_storage_container.azfunc-sa-container.name}"
  storage_authentication_type   = "StorageAccountConnectionString"
  storage_access_key            = azurerm_storage_account.azfunc-sa.primary_access_key
  runtime_name                  = "custom"
  runtime_version               = "1.0"
  https_only                    = true
  
  public_network_access_enabled = true
  #virtual_network_subnet_id     = var.azfunc_subnet_id
  
  site_config {
    application_insights_connection_string  = azurerm_application_insights.azfunc-app-insights.connection_string
    application_insights_key                = azurerm_application_insights.azfunc-app-insights.instrumentation_key
  }
}