output "resource_group_name" {
  value = module.resource_group.name
}

output "aks_name" {
  value = module.aks.aks_name
}

output "public_ip_fqdn" {
  value = module.public_ip.fqdn
}

output "public_ip_address" {
  value = module.public_ip.ip_address
}

output "storage_account_name" {
  description = "Nome da conta de armazenamento"
  value       = module.blob.storage_account_name
}

output "storage_container_name" {
  description = "Nome do container"
  value       = module.blob.storage_container_name
}

output "storage_account_connection_string" {
  description = "Connection string primária da conta de armazenamento"
  value       = module.blob.storage_account_connection_string
  sensitive   = true
}