#
#
# Virtual WAN topology (including virtual hubs, firewalls and routes configuration)
#
#

# Outputs
output "virtual_wans" {
  value = module.virtual_wans

  description = "Virtual WAN output"
}

module "virtual_wans" {
  source   = "./modules/networking/virtual_wan"
  for_each = local.networking.virtual_wans

  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  resource_groups     = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)]
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}
  virtual_networks    = local.combined_objects_networking
  public_ip_addresses = local.combined_objects_public_ip_addresses
}

