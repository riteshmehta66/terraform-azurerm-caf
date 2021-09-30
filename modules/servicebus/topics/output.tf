output "id" {
  value = azurerm_servicebus_topic.sbt.id
}

output "topic_name" {
  value       = azurerm_servicebus_topic.sbt.name
  description = "Name of the topic"
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}
