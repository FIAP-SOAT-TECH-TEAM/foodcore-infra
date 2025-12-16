output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_resource_group" {
  description = "Resource Group onde o cluster AKS reside"
  value       = azurerm_kubernetes_cluster.aks.resource_group_name
}

output "aks_secret_identity_client_id" {
  description = "Client ID da identidade atribuída ao Pod Azure Key Vault Provider do Add-On instalado (Workload Identity)."
  value       = local.secrets_store_csi_identity_client_id
}