module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "public_ip" {
  source              = "./modules/public_ip"
  dns_prefix          = var.dns_prefix
  resource_group_name = module.resource_group.name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = var.sku
}

module "blob" {
  source                    = "./modules/blob"
  dns_prefix                = var.dns_prefix
  resource_group_name       = module.resource_group.name
  location                  = var.location
  container_name            = var.container_name
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
}

module "aks" {
  source              = "./modules/aks"
  dns_prefix          = var.dns_prefix
  resource_group_name = module.resource_group.name
  resource_group_id   = module.resource_group.id
  location            = var.location
  node_count          = var.node_count
  vm_size             = var.vm_size
  identity_type       = var.identity_type
  kubernetes_version  = var.kubernetes_version
}