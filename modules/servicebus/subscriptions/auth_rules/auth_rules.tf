resource "azurecaf_name" "sbs_rule" {
  name          = var.settings.name
  resource_type = "azurerm_servicebus_subscription_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_subscription_rule" "sbs_rule" {
  name                = azurecaf_name.sbs_rule.result
  namespace_name      = var.namespace_name
  topic_name          = var.topic_name
  subscription_name   = var.subscription_name
  resource_group_name = var.resource_group_name
  filter_type         = var.settings.filter_type
  correlation_filter  = var.settings.correlation_filter
  action              = var.settings.action
}