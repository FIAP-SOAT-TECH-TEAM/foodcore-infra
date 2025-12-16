resource "azurerm_key_vault" "akv" {
  name                          = "${var.dns_prefix}-akv"
  location                      = var.location
  sku_name                      = var.akv_sku_name
  resource_group_name           = var.resource_group_name
  enabled_for_disk_encryption   = true
  tenant_id                     = var.tenant_id
  soft_delete_retention_days    = var.akv_soft_delete_retention_days
  public_network_access_enabled = false

  # Apenas para fins de atividade
  purge_protection_enabled    = false

  rbac_authorization_enabled  = true
}

resource "azurerm_private_endpoint" "akv_private_endpoint" {
  name                = "${var.dns_prefix}-akv-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.akv_subnet_id

  private_service_connection {
    name                           = "${var.dns_prefix}-akv-pe"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.akv.id
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "akv-dns-zone-group"
    private_dns_zone_ids = [var.akv_private_dns_zone_id]
  }
}

resource "azurerm_key_vault_secret" "server_mail_username" {
  name         = "server_mail_username"
  value        = var.server_mail_username
  key_vault_id = azurerm_key_vault.akv.id

  tags = {
    microservice = "any"
    resource  = "smtp_server"
  }

}

resource "azurerm_key_vault_secret" "aws_credentials" {
  name         = "aws_credentials"
  value        = var.aws_credentials
  key_vault_id = azurerm_key_vault.akv.id

  tags = {
    microservice = "any"
    resource  = "any_aws_service"
  }

}

resource "azurerm_key_vault_secret" "server_mail_password" {
  name         = "server_mail_password"
  value        = var.server_mail_password
  key_vault_id = azurerm_key_vault.akv.id

  tags = {
    microservice = "any"
    resource  = "smtp_server"
  }

}

resource "azurerm_key_vault_secret" "server_mail_host" {
  name         = "server_mail_host"
  value        = var.server_mail_host
  key_vault_id = azurerm_key_vault.akv.id

  tags = {
    microservice = "any"
    resource  = "smtp_server"
  }

}

resource "azurerm_key_vault_secret" "server_mail_port" {
  name         = "server_mail_port"
  value        = var.server_mail_port
  key_vault_id = azurerm_key_vault.akv.id

  tags = {
    microservice = "any"
    resource  = "smtp_server"
  }

}