module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "vnet" {
  source                  = "./modules/vnet"
  dns_prefix              = var.dns_prefix
  resource_group_name     = module.resource_group.name
  location                = var.location
  vnet_prefix             = var.vnet_prefix
  vnet_aks_subnet_prefix  = var.vnet_aks_subnet_prefix
  vnet_apim_subnet_prefix = var.vnet_apim_subnet_prefix
  vnet_db_subnet_prefix   = var.vnet_db_subnet_prefix
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

module "acr" {
  source              = "./modules/acr"
  dns_prefix          = var.dns_prefix
  resource_group_name = module.resource_group.name
  location            = var.location
  acr_sku             = var.acr_sku
  acr_admin_enabled   = var.acr_admin_enabled
}

module "aks" {
  source              = "./modules/aks"
  dns_prefix          = var.dns_prefix
  resource_group_name = module.resource_group.name
  location            = var.location
  aks_subnet_id       = module.vnet.aks_subnet.id
  node_count          = var.node_count
  vm_size             = var.vm_size
  identity_type       = var.identity_type
  kubernetes_version  = var.kubernetes_version
  aks_service_cidr    = var.vnet_aks_service_subnet_prefix
  aks_dns_service_ip  = var.vnet_aks_dns_service_ip
  acr_id              = module.acr.acr_id
}

module "apim" {
  source                          = "./modules/apim"
  dns_prefix                      = var.dns_prefix
  resource_group_name             = module.resource_group.name
  location                        = var.location
  apim_subnet_id                  = module.vnet.apim_subnet.id
  publisher_name                  = var.publisher_name
  publisher_email                 = var.publisher_email
  sku_name                        = var.sku_name
  apim_product_id                 = var.apim_product_id
  apim_product_display_name       = var.apim_product_display_name
  apim_product_description        = var.apim_product_description
  apim_subscription_display_name  = var.apim_subscription_display_name
  apim_subscription_state         = var.apim_subscription_state
}