output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_resource_group" {
  description = "Resource Group onde o cluster AKS reside"
  value       = azurerm_kubernetes_cluster.aks.resource_group_name
}