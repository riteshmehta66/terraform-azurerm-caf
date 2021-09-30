resource "azurecaf_name" "sb_ns_rule_name" {
  name          = var.settings.rule_name
  resource_type = "azurerm_servicebus_namespace_authorization_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_namespace_authorization_rule" "sb_ns_rule" {
  name                = azurecaf_name.sb_ns_rule_name.result
  namespace_name      = var.namespace_name
  resource_group_name = var.resource_group_name
  listen              = var.settings.listen
  send                = var.settings.send
  manage              = var.settings.manage
}