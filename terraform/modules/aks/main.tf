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
  }

  identity {
    type = var.identity_type
  }
}

# Permissão para o AKS acessar o grupo de recursos que contém o IP público
resource "azurerm_role_assignment" "aks_network_contributor" {
  scope                = var.resource_group_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}