locals {
   backend_address_pool_name              = "${dns_prefix}-beap"
   frontend_private_port_name             = "${dns_prefix}-private-port"
   frontend_public_ip_configuration_name  = "${dns_prefix}-public-config"
   frontend_private_ip_configuration_name = "${dns_prefix}-private-config"
   http_setting_name                      = "${dns_prefix}-be-htst"
   listener_name                          = "${dns_prefix}-httplstn"
   request_routing_rule_name              = "${dns_prefix}-rqrt"
}