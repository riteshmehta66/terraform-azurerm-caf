output "id" {
  value = azurerm_servicebus_subscription.sbs.id
}

output "subscription_name" {
  value       = azurerm_servicebus_subscription.sbs.name
  description = "Name of the subscription"
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}
