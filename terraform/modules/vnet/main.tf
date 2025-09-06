resource "azurerm_virtual_network" "vnet" {
  name                = "${var.dns_prefix}-vnet"
  address_space       = var.vnet_prefix
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "${var.dns_prefix}-aks-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vnet_aks_subnet_prefix
}

resource "azurerm_subnet" "apim_subnet" {
  name                 = "${var.dns_prefix}-apim-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vnet_apim_subnet_prefix
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.dns_prefix}-db-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vnet_db_subnet_prefix

  delegation {
    name = "fs"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet" "azfunc_subnet" {
  name                 = "${var.dns_prefix}-azfunc-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vnet_azfunc_subnet_prefix

  delegation {
    name = "Microsoft.Web.serverFarms"

    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
      ]
    }
    
  }
}

resource "azurerm_private_dns_zone" "private_dns" {
  name                = "${var.dns_prefix}.local"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "postgres_private_dns" {
  name                = "${var.dns_prefix}.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "${var.dns_prefix}-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = true
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_vnet_link" {
  name                  = "${var.dns_prefix}-postgres-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.postgres_private_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = false
}

resource "azurerm_private_dns_a_record" "api_dns_a" {
  name                = "api"
  zone_name           = azurerm_private_dns_zone.private_dns.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [cidrhost(azurerm_subnet.aks_subnet.address_prefixes[0], -2)]
}