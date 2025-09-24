resource "azurerm_network_security_group" "apim_nsg" {
  name                = "${var.dns_prefix}-apim-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowHttpsInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHttpInbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowApimMgmtInbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "AzureCloud"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "apim_assoc" {
  subnet_id                 = var.apim_subnet_id
  network_security_group_id = azurerm_network_security_group.apim_nsg.id
}

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

  depends_on = [ azurerm_subnet_network_security_group_association.apim_assoc ]
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

      <!-- Rate limit: 100 chamadas por 60 segundos por assinatura -->
      <rate-limit-by-key 
        calls="100" 
        renewal-period="60" 
        counter-key="@(context.Subscription?.Key)" />

      <!-- Cache de resposta por 60 segundos -->
      <cache-lookup vary-by-developer="false" 
                    vary-by-developer-groups="false" 
                    vary-by-query-parameters="true" />
    </inbound>

    <backend>
      <base />
    </backend>

    <outbound>
      <base />

      <!-- Armazena a resposta no cache -->
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