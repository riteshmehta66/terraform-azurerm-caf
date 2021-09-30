output "id" {
  value = azurerm_servicebus_subscription_rule.sbs_rule.id
}

output "name" {
  value       = azurerm_servicebus_subscription_rule.sbs_rule.name
  description = "Name of the servicebus subscription rule"
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}
