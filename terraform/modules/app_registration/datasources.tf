data "azuread_application" "graph_api_app" {
  client_id = "00000003-0000-0000-c000-000000000000"
}

data "azuread_application_oauth2_permission_scope" "graph_directory_read_write_all" {
  application_id = data.azuread_application.graph_api_app.application_id
  value          = "Directory.ReadWrite.All"
}