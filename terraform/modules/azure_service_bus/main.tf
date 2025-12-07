resource "azurerm_servicebus_namespace" "sb_ns" {
  name                          = "${var.dns_prefix}-sb-namespace"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sb_sku
  public_network_access_enabled = false
  capacity                      = var.sb_capacity
  premium_messaging_partitions  = var.sb_partitions


  # https://github.com/hashicorp/terraform-provider-azurerm/issues/27239#issuecomment-2420234755
  #zone_redundant     = true
}

resource "azurerm_servicebus_queue" "sb_queues" {
  for_each                                  = var.sb_queues

  name                                      = each.key
  namespace_id                              = azurerm_servicebus_namespace.sb_ns.id

  dead_lettering_on_message_expiration      = each.value.DeadLetteringOnMessageExpiration
  default_message_ttl                       = each.value.DefaultMessageTimeToLive
  duplicate_detection_history_time_window   = each.value.DuplicateDetectionHistoryTimeWindow
  lock_duration                             = each.value.LockDuration
  max_delivery_count                        = each.value.MaxDeliveryCount
  requires_duplicate_detection              = each.value.RequiresDuplicateDetection
  requires_session                          = each.value.RequiresSession
}

resource "azurerm_servicebus_topic" "sb_topics" {
  for_each = var.sb_topics

  name                                      = each.key
  namespace_id                              = azurerm_servicebus_namespace.sb_ns.id

  default_message_ttl                       = each.value.Properties.DefaultMessageTimeToLive
  duplicate_detection_history_time_window   = each.value.Properties.DuplicateDetectionHistoryTimeWindow
  requires_duplicate_detection              = each.value.Properties.RequiresDuplicateDetection
}

resource "azurerm_servicebus_subscription" "sb_subscriptions" {
  for_each = var.sb_subscriptions

  name                                  = each.key
  topic_id                              = azurerm_servicebus_topic.sb_topics[each.value.topic_name].id

  dead_lettering_on_message_expiration  = each.value.properties.DeadLetteringOnMessageExpiration
  default_message_ttl                   = each.value.properties.DefaultMessageTimeToLive
  lock_duration                         = each.value.properties.LockDuration
  max_delivery_count                    = each.value.properties.MaxDeliveryCount
  requires_session                      = each.value.properties.RequiresSession
}

resource "azurerm_private_endpoint" "sb_private_endpoint" {
  name                = "${var.dns_prefix}-sb-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.sb_subnet_id

  private_service_connection {
    name                           = "${var.dns_prefix}-sb-pe"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_servicebus_namespace.sb_ns.id
    subresource_names              = ["namespace"]
  }

  private_dns_zone_group {
    name                 = "sb-dns-zone-group"
    private_dns_zone_ids = [var.sb_private_dns_zone_id]
  }
}