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
    sku                = "Basic"
    capacity           = 0                # Optional: supports only capacity = 0 with Standard and Basic sku
    // zone_redundant     = true             # Optional: only with Premium sku

  }
}
