locals {
  app_roles = [
    {
      display_name = "ADMIN"
      value        = "ADMIN"
      description  = "Administradores do restaurante"
    },
    {
      display_name = "USER"
      value        = "USER"
      description  = "Clientes do restaurante"
    }
  ]
  admin_role_id = one([
    for r in azuread_application.api_app_registration.app_role : r.id
    if r.value == "ADMIN"
  ])
}