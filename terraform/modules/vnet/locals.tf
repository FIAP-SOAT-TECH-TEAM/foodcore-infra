locals {
  aks_ingress_private_ip  = cidrhost(azurerm_subnet.aks_node_subnet.address_prefixes[0], -2)
  azfunc_private_ip       = cidrhost(azurerm_subnet.azfunc_pe_subnet.address_prefixes[0], -2)
}