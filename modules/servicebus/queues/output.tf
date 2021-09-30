output "id" {
  value = azurerm_servicebus_queue.sbq.id
}

output "queue_name" {
  value       = azurerm_servicebus_queue.sbq.name
  description = "Name of the queue"
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}
