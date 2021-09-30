resource "azurecaf_name" "sbt" {
  name          = var.settings.topic_name
  resource_type = "azurerm_servicebus_topic"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_topic" "sbt" {
  name                = azurecaf_name.sbt.result
  namespace_name      = var.namespace_name
  resource_group_name = var.resource_group_name
  max_size_in_megabytes     = try(var.settings.max_size_in_megabytes, 1024)
  requires_duplicate_detection = try(var.settings.requires_duplicate_detection, false)
  default_message_ttl       = try(var.settings.default_message_ttl, null)
  duplicate_detection_history_time_window = try(var.settings.duplicate_detection_history_time_window, "PT10M")
  status                    = try(var.settings.status, "Active")
  enable_batched_operations = try(var.settings.enable_batched_operations, true) 
  auto_delete_on_idle       = try(var.settings.auto_delete_on_idle, null)
  enable_partitioning          = try(var.settings.enable_partitioning, false)      # For Premium sku it must be true
  enable_express               = try(var.settings.enable_express, false)     # for Premium sku it must be false
  support_ordering             = try(var.settings.support_ordering, false)
}