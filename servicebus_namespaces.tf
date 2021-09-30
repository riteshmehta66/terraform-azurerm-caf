
module "servicebus_namespaces" {
  source   = "./modules/servicebus/namespaces"
  for_each = var.servicebus_namespaces

  global_settings     = local.global_settings
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]  
  client_config       = local.client_config
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}
}

output "servicebus_namespaces" {
  value = module.servicebus_namespaces
}

module "servicebus_namespace_auth_rules" {
  source   = "./modules/servicebus/namespaces/auth_rules"
  for_each = try(var.servicebus_namespace_auth_rules, {})

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  namespace_name      = module.servicebus_namespaces[each.value.servicebus_namespace_key].name
  
  depends_on = [
    module.servicebus_namespaces
  ]
}

module "servicebus_namespaces_diagnostics" {
  source   = "./modules/diagnostics"
  for_each = var.servicebus_namespaces

  resource_id       = module.servicebus_namespaces[each.key].id
  resource_location = module.servicebus_namespaces[each.key].location
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}


module servicebus_queues {
  source   = "./modules/servicebus/queues"
  for_each = try(var.servicebus_queues, {})

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  namespace_name      = module.servicebus_namespaces[each.value.servicebus_namespace_key].name
  
  depends_on = [
    module.servicebus_namespaces
  ]
}

output "servicebus_queues" {
  value = module.servicebus_queues
}

module "servicebus_queue_auth_rules" {
  source   = "./modules/servicebus/queues/auth_rules"
  for_each = try(var.servicebus_queue_auth_rules, {})

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  namespace_name      = module.servicebus_namespaces[each.value.servicebus_namespace_key].name
  queue_name          = module.servicebus_queues[each.value.servicebus_queue_key].queue_name 
  
  
  depends_on = [
    module.servicebus_namespaces,
    module.servicebus_queues
  ]
}


module servicebus_topics {
  source   = "./modules/servicebus/topics"
  for_each = try(var.servicebus_topics, {})

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  namespace_name      = module.servicebus_namespaces[each.value.servicebus_namespace_key].name
  
  depends_on = [
    module.servicebus_namespaces
  ]
}

output "servicebus_topics" {
  value = module.servicebus_topics
}


module "servicebus_topic_auth_rules" {
  source   = "./modules/servicebus/topics/auth_rules"
  for_each = try(var.servicebus_topic_auth_rules, {})

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  namespace_name      = module.servicebus_namespaces[each.value.servicebus_namespace_key].name
  topic_name          = module.servicebus_topics[each.value.servicebus_topic_key].topic_name
  
  
  
  depends_on = [
    module.servicebus_namespaces,
    module.servicebus_topics
  ]
}


module servicebus_subscriptions {
  source   = "./modules/servicebus/subscriptions"
  for_each = try(var.servicebus_subscriptions, {})

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  namespace_name      = module.servicebus_namespaces[each.value.servicebus_namespace_key].name
  topic_name          = module.servicebus_topics[each.value.servicebus_topic_key].topic_name
  
  depends_on = [
    module.servicebus_namespaces,
    module.servicebus_topics
  ]
}

output "servicebus_subscriptions" {
  value = module.servicebus_subscriptions
}



// module "servicebus_subscription_rules" {
//   source   = "./modules/servicebus/subscriptions/auth_rules"
//   for_each = try(var.servicebus_subscription_rules, {})

//   resource_group_name = local.resource_groups[each.value.resource_group_key].name
//   client_config       = local.client_config
//   global_settings     = local.global_settings
//   settings            = each.value
//   namespace_name      = module.servicebus_namespaces[each.value.servicebus_namespace_key].name
//   topic_name          = module.servicebus_topics[each.value.servicebus_topic_key].topic_name
//   subscription_name   = module.servicebus_subscriptions[each.value.servicebus_subscription_key].subscription_name
  
  
  
//   depends_on = [
//     module.servicebus_namespaces,
//     module.servicebus_topics,
//     module.servicebus_subscriptions
//   ]
// }