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
}