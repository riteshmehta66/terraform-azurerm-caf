output "id" {
  description = "The Servicebus Namespace ID."
  value       = azurerm_servicebus_namespace.sb.id
}

output "name" {
  description = "The Servicebus Namespace name."
  value       = azurerm_servicebus_namespace.sb.name
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}

output "location" {
  value       = var.location
  description = "Location of the service"
}

// output "event_hubs" {
//   value = module.event_hubs
// }