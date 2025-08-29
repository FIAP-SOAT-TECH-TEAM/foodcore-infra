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