resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.dns_prefix}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.aks_subnet_id
  }

  identity {
    type = var.identity_type
  }
}