resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.dns_prefix}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  
  default_node_pool {
    name                        = var.node_pool_name
    node_count                  = var.node_count
    vm_size                     = var.vm_size
    vnet_subnet_id              = var.aks_node_subnet_id
    auto_scaling_enabled        = var.aks_auto_scaling_enabled
    max_count                   = var.aks_max_count
    min_count                   = var.aks_min_count
    zones                       = var.aks_availability_zones
    node_public_ip_enabled      = false
    temporary_name_for_rotation = var.node_pool_temp_name
  }

  identity {
    type = var.identity_type
  }

  network_profile {
    network_plugin      = var.aks_network_plugin
    network_plugin_mode = var.aks_network_plugin_mode
    outbound_type       = var.aks_outbound_type
  }

  role_based_access_control_enabled = true
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id

  depends_on = [azurerm_kubernetes_cluster.aks]
}

resource "azurerm_role_assignment" "aks_subnet_contributor" {
  scope                = var.aks_node_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id

  depends_on = [azurerm_kubernetes_cluster.aks]
}

# Permissão para o AKS acessar o grupo de recursos que contém o IP público
resource "azurerm_role_assignment" "aks_network_contributor" {
  scope                = var.public_ip_resource_group_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}