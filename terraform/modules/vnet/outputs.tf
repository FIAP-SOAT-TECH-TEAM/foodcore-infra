output "aks_subnet_last_usable_ip" {
  description = "Último endereço IP utilizável da subnet do AKS (exclui o IP final reservado e broadcast)."
  value       = cidrhost(azurerm_subnet.aks_subnet.address_prefixes[0], -2)
}