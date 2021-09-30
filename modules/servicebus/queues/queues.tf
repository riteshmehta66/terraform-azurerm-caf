resource "azurecaf_name" "sbq" {
  name          = var.settings.queue_name
  resource_type = "azurerm_servicebus_queue"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_queue" "sbq" {
  name                = azurecaf_name.sbq.result
  namespace_name      = var.namespace_name
  resource_group_name = var.resource_group_name
  lock_duration             = try(var.settings.lock_duration, "PT1M")
  max_size_in_megabytes     = try(var.settings.max_size_in_megabytes, 1024)
  requires_duplicate_detection = try(var.settings.requires_duplicate_detection, false)
  requires_session          = try(var.settings. requires_session, false)
  default_message_ttl       = try(var.settings.default_message_ttl, null)
  dead_lettering_on_message_expiration  = try(var.settings.dead_lettering_on_message_expiration, false)
  duplicate_detection_history_time_window = try(var.settings.duplicate_detection_history_time_window, "PT10M")
  max_delivery_count        = try(var.settings.max_delivery_count, 10)
  status                    = try(var.settings.status, "Active")
  enable_batched_operations = try(var.settings.enable_batched_operations, true) 
  auto_delete_on_idle       = try(var.settings.auto_delete_on_idle, null)
  enable_partitioning          = try(var.settings.enable_partitioning, false)      # For Premium sku it must be true
  enable_express               = try(var.settings.enable_express, false)     # for Premium sku it must be false
  
  # pending
  // forward_to                   =
  // forward_dead_lettered_messages_to = 

}