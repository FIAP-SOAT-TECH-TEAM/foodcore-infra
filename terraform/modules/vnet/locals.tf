locals {
  aks_api_private_ip = cidrhost(azurerm_subnet.aks_subnet.address_prefixes[0], -2)
  azfunc_private_ip = cidrhost(azurerm_subnet.pe_subnet.address_prefixes[0], -2)
}