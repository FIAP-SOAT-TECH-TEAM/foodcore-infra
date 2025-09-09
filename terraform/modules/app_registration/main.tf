# Define a App Registration da API
resource "azuread_application" "api_app_registration" {
  display_name = var.api_app_display_name

  # Expondo a API com uma URI
  identifier_uris = ["api://${uuid()}"]

  api {
    requested_access_token_version = 2
  }

  dynamic "app_role" {
    for_each = local.app_roles
    content {
      allowed_member_types = ["User"]
      display_name         = app_role.value.display_name
      value                = app_role.value.value
      description          = app_role.value.description
      enabled              = true
      id                   = uuid()
    }
  }
}
# Define a App Registration da Function App de autenticação
resource "azuread_application" "auth_function_app_registration" {
  display_name = var.auth_function_app_display_name

  # Adiciona permissão para a Function App acessar o Microsoft Graph
  required_resource_access {
    resource_app_id = data.azuread_application.graph_api_app.application_id

    resource_access {
      id   = data.azuread_application_oauth2_permission_scope.graph_directory_read_write_all.id
      type = "Scope"
    }
  }
}

# Cria o Service Principal para a API
resource "azuread_service_principal" "api_sp" {
  client_id = azuread_application.api_app_registration.client_id
}
# Cria o Service Principal para a Function App
resource "azuread_service_principal" "auth_function_sp" {
  client_id = azuread_application.auth_function_app_registration.client_id
}

# Permite que a Function App execute operações no Microsoft Graph
resource "azuread_service_principal_delegated_permission_grant" "auth_function_graph_permissions" {
  service_principal_object_id          = azuread_service_principal.auth_function_sp.object_id
  resource_service_principal_object_id = data.azuread_application.graph_api_app.service_principal_object_id
  claim_values                         = ["Directory.ReadWrite.All"]
}

resource "azuread_user" "admin_user" {
  user_principal_name   = "admin_foodcore@${var.admin_default_password}.com"
  display_name          = "FoodCore Admin User"
  mail_nickname         = "admin"
  password              = var.admin_default_password
  force_password_change = false
}

resource "azuread_app_role_assignment" "admin_role_assignment" {
  principal_object_id = azuread_user.admin_user.object_id
  app_role_id         = azuread_application.api_app_registration.app_role[0].id
  resource_object_id  = azuread_service_principal.api_sp.object_id
}