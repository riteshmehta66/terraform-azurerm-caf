resource "azurecaf_name" "sb" {
  name          = var.settings.name
  resource_type = "azurerm_servicebus_namespace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_namespace" "sb" {
  name                     = azurecaf_name.sb.result
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = var.settings.sku
  capacity                 = try(var.settings.capacity, null)
  tags                     = local.tags  
  zone_redundant           = try(var.settings.zone_redundant, null)
}
