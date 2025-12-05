resource "azurerm_api_management" "apim" {
  name                = "${var.dns_prefix}-apim"
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.sku_name

  virtual_network_type = "External"

  virtual_network_configuration {
    subnet_id = var.apim_subnet_id
  }
}

resource "azurerm_api_management_logger" "app_insights_logger" {
  name                = "${var.dns_prefix}-apim-logger"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group_name
  
  application_insights {
    instrumentation_key = var.app_insights_instrumentation_key
  }

  depends_on = [ azurerm_api_management.apim ]
}

resource "azurerm_api_management_product" "foodcoreapi_start_product" {
  product_id            = var.apim_product_id
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = var.resource_group_name

  display_name          = var.apim_product_display_name
  description           = var.apim_product_description
  subscription_required = true
  approval_required     = false
  published             = true
}

resource "azurerm_api_management_product_policy" "foodcoreapi_start_product_policy" {
  api_management_name = azurerm_api_management.apim.name
  product_id          = azurerm_api_management_product.foodcoreapi_start_product.product_id
  resource_group_name = var.resource_group_name

  xml_content = <<XML
  <policies>
    <inbound>
      <base />

      <!-- Rate limit (por assinatura) -->
      <rate-limit-by-key 
        calls="100" 
        renewal-period="60" 
        counter-key="@(context.Subscription?.Key)" />

      <!-- Cache de resposta -->
      <cache-lookup 
        vary-by-developer="false" 
        vary-by-developer-groups="false"
        caching-type="internal"
        downstream-caching-type="private"
        must-revalidate="true"
        allow-private-response-caching="true">
        
        <!-- Headers que fazem o cache variar -->
        <vary-by-header>Authorization</vary-by-header>

        <!-- Query parameters que fazem o cache variar -->
        <vary-by-query-parameter>id</vary-by-query-parameter>
        <vary-by-query-parameter>topic</vary-by-query-parameter>
      </cache-lookup>
    </inbound>

    <backend>
      <base />
    </backend>

    <outbound>
      <base />

      <!-- Armazena a resposta em cache -->
      <cache-store duration="60" />
    </outbound>

    <on-error>
      <base />
    </on-error>
  </policies>
  XML
}

resource "azurerm_api_management_subscription" "foodcoreapi_start_subscription" {
  api_management_name  = azurerm_api_management.apim.name
  resource_group_name  = var.resource_group_name

  product_id           = azurerm_api_management_product.foodcoreapi_start_product.id
  display_name         = var.apim_subscription_display_name
  state                = var.apim_subscription_state
}