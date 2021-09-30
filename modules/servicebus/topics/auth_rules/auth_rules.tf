resource "azurecaf_name" "sbt_auth_rule_name" {
  name          = var.settings.name
  resource_type = "azurerm_servicebus_topic_authorization_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_topic_authorization_rule" "sbt_rule" {
  name                = azurecaf_name.sbt_auth_rule_name.result
  namespace_name      = var.namespace_name
  topic_name          = var.topic_name
  resource_group_name = var.resource_group_name
  listen              = var.settings.listen
  send                = var.settings.send
  manage              = var.settings.manage
}