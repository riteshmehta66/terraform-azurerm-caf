landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "caf_foundations_sharedservices"
  level               = "level2"
  key                 = "caf_level2_servicebus"
  tfstates = {
    caf_foundations_sharedservices = {
      level   = "lower"
      tfstate = "caf_foundations_sharedservices.tfstate"
    }
    // caf_foundations_network = {
    //   level   = "lower"
    //   tfstate = "caf_foundations_network.tfstate"
    // }
    // caf_networking_vnets_network = {
    //   level   = "current"
    //   tfstate = "caf_networking_vnets_network.tfstate"
    // }

  }
}

global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
    region2 = "centralus"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  sb_ns_examples = {
    name   = "sb_ns_examples"
    region = "region1"
  }
}

servicebus_namespaces = {
  sb_ns1 = {
    name               = "sb_ns1"
    resource_group_key = "sb_ns_examples"
    region             = "region1"
    sku                = "Standard"
    capacity           = 0                # Optional: supports only capacity = 0 with Standard and Basic sku
    // zone_redundant     = true             # Optional: only with Premium sku

    diagnostic_profiles = {
      diagnostics_storage_account = {
        name             = "diagnostics-storageaccount"
        definition_key   = "servicebus_namespace"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      diagnostics_log_analytic = {
        name             = "diagnostics-loganalytics"
        definition_key   = "servicebus_namespace"
        destination_type = "log_analytics"
        destination_key  = "eus_logs"
      }
      operationsevh = {
        name             = "diagnostics-eventhub"
        definition_key   = "servicebus_namespace"
        destination_type = "event_hub"
        destination_key  = "eus_evh"
      }
    }

    tags   = {    
      "environment"       = "prd"
      "termination_date"  = "NONE"      
      "description"       = "Servicebus Namespace"
    }
  }
}

servicebus_namespace_auth_rules = {
  rule1 = {
    resource_group_key      = "sb_ns_examples"
    servicebus_namespace_key = "sb_ns1"    
    rule_name               = "sb_ns-auth_rule1"
    listen                  = true
    send                    = true
    manage                  = false
  }
}


servicebus_queues = {
  queue1 = {
    resource_group_key                      = "sb_ns_examples"
    servicebus_namespace_key                = "sb_ns1"  
    queue_name                              = "queue1"
    lock_duration                           = "PT1M"
    max_size_in_megabytes                   = 1024
    requires_duplicate_detection            = false          # Dafaults to false. Only Premium sku can use true.
    requires_session                        = false             # Dafaults to false. Only Premium sku can use true.
    // default_message_ttl                  = "PT10M"
    dead_lettering_on_message_expiration    = true
    duplicate_detection_history_time_window = "PT10M"
    max_delivery_count                      = 10
    status                                  = "Active"
    enable_batched_operations               = true 
    // auto_delete_on_idle                  = 
    enable_partitioning                     = false      # Defaults to false. For Premium sku it must be true
    enable_express                          = false     # Defaults to false. For Premium sku it must be false
    // forward_to                           =
    // forward_dead_lettered_messages_to    = 
  }
}

servicebus_queue_auth_rules = {
  rule1 = {
    resource_group_key      = "sb_ns_examples"
    servicebus_namespace_key = "sb_ns1"
    servicebus_queue_key     =  "queue1"    
    name                     = "sb-queue-auth_rule1"
    listen                   = true
    send                     = true
    manage                   = false
  }
}

# Topics can only be created in Namespaces with an SKU of standard or higher
# Both enable_express (DelayedPersistence) property and requires_duplicate_detection property cannot be enabled together

servicebus_topics = {
  topic1 = {
    resource_group_key                      = "sb_ns_examples"
    servicebus_namespace_key                = "sb_ns1"  
    topic_name                              = "topic1"
    // lock_duration                           = "PT1M"
    max_size_in_megabytes                   = 1024
    requires_duplicate_detection            = true          # Dafaults to false. Only Premium sku can use true.
    requires_session                        = true             # Dafaults to false. Only Premium sku can use true.
    // default_message_ttl                  = "PT2160H"        # default value not specified on Terraform. Need guidance/feedback.
    // dead_lettering_on_message_expiration    = true
    duplicate_detection_history_time_window = "PT10M"
    // max_delivery_count                      = 10
    status                                  = "Active"
    enable_batched_operations               = true 
    // auto_delete_on_idle                  = 
    enable_partitioning                     = true      # Defaults to false. For Premium sku it must be true
    enable_express                          = false     # Defaults to false. For Premium sku it must be false
    support_ordering                        = true
  }
}

servicebus_topic_auth_rules = {
  rule1 = {
    resource_group_key      = "sb_ns_examples"
    servicebus_namespace_key = "sb_ns1"
    servicebus_topic_key     =  "topic1"    
    name                     = "sb-topic-auth_rule1"
    listen                   = true
    send                     = true
    manage                   = false
  }
}






