 data "azurerm_user_assigned_identity" "agic_identity" {
   name                = "ingressapplicationgateway-${azurerm_kubernetes_cluster.aks.name}"
   resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
 }