output "id" {
  value = azurerm_servicebus_queue_authorization_rule.sbq_rule.id
}

output "primary_key" {
  value = azurerm_servicebus_queue_authorization_rule.sbq_rule.primary_key
}

output "secondary_key" {
  value = azurerm_servicebus_queue_authorization_rule.sbq_rule.secondary_key
}

output "primary_connection_string" {
  value = azurerm_servicebus_queue_authorization_rule.sbq_rule.primary_connection_string
}

output "secondary_connection_string" {
  value = azurerm_servicebus_queue_authorization_rule.sbq_rule.secondary_connection_string
}

output "primary_connection_string_alias" {
  value = azurerm_servicebus_queue_authorization_rule.sbq_rule.primary_connection_string_alias
}

output "secondary_connection_string_alias" {
  value = azurerm_servicebus_queue_authorization_rule.sbq_rule.secondary_connection_string_alias
}

output "name" {
  value       = azurerm_servicebus_queue_authorization_rule.sbq_rule.name
  description = "Name of the authorization rule"
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}
