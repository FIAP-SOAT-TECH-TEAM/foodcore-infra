resource "azurerm_virtual_network" "vnet" {
  name                = "${var.dns_prefix}-vnet"
  address_space       = var.vnet_prefix
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "aks" {
  name                 = "${var.dns_prefix}-aks-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vnet_aks_subnet_prefix
}

resource "azurerm_subnet" "apim" {
  name                 = "${var.dns_prefix}-apim-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vnet_apim_subnet_prefix
}