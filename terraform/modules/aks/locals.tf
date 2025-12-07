locals {
  aks_dns_service_ip  = cidrhost(var.aks_service_subnet_prefix, -2)
}