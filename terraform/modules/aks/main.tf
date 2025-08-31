resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.dns_prefix}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name            = "default"
    node_count      = var.node_count
    vm_size         = var.vm_size
    vnet_subnet_id  = var.aks_subnet_id
  }

  identity {
    type = var.identity_type
  }

  network_profile {
    network_plugin    = "azure"
    service_cidr      = var.aks_service_cidr
    dns_service_ip    = var.aks_dns_service_ip
  }

  role_based_access_control_enabled = true
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "aks_subnet_contributor" {
  scope                = var.aks_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}