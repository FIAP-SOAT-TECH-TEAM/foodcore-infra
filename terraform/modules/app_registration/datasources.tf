data "azuread_application" "graph_api_app" {
  client_id = "00000003-0000-0000-c000-000000000000"
}

data "azuread_service_principal" "graph_api_sp" {
  display_name  = data.azuread_application.graph_api_app.display_name
}