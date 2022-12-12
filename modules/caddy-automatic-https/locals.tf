locals {
  # Get a name from the descriptor. If not available, use default naming convention.
  # Trim and replace function are used to avoid bare delimiters on both ends of the name and situation of adjacent delimiters.
  name_from_descriptor = trim(replace(
    lookup(module.this.descriptors, var.descriptor_name, module.this.id),
    "/${module.this.delimiter}${module.this.delimiter}+/",
  module.this.delimiter), module.this.delimiter)

  location            = coalesce(one(data.azurerm_resource_group.this[*].location), var.location)
  resource_group_name = coalesce(one(data.azurerm_resource_group.this[*].name), var.resource_group_name)

  dns_name_label = (length(var.subnet_ids) == 0 ? (
    var.dns_name_label != null ?
    var.dns_name_label : local.name_from_descriptor
  ) : null)

  hostname = coalesce(var.hostname, format(
    "%s.%s.azurecontainer.io",
    local.dns_name_label,
    local.location
  ))

  atlantis_environment_variables = merge(
    { ATLANTIS_ATLANTIS_URL = format("https://%s", local.hostname) },
    var.atlantis_container.environment_variables
  )

  atlantis_port = try(var.atlantis_container.ports[0].port, 4141)

  caddy_persistence_storage_account = {
    name = (var.caddy_persistence_storage_account == null
      ? module.caddy_persistence_storage_account.storage_account_name
      : var.caddy_persistence_storage_account.name
    )
    key = (var.caddy_persistence_storage_account == null
      ? module.caddy_persistence_storage_account.storage_primary_access_key
      : var.caddy_persistence_storage_account.key
    )
    share_name = var.caddy_persistence_storage_account == null ? "caddy" : var.caddy_persistence_storage_account.name
  }

  caddyfile_base64_encoded = coalesce(
    var.caddyfile.base64_encoded,
    base64encode(templatefile(
      coalesce(try(var.caddyfile.template.path, null), "${path.module}/templates/Caddyfile.tpl"),
      merge({
        hostname      = local.hostname
        atlantis_port = local.atlantis_port
      }, try(var.caddyfile.template.parameters, null))
    ))
  )

  caddy_container = merge(var.caddy_container, {
    volumes = merge({
      caddy-data = {
        mount_path           = "/data/caddy"
        storage_account_name = local.caddy_persistence_storage_account.name
        storage_account_key  = local.caddy_persistence_storage_account.key
        share_name           = local.caddy_persistence_storage_account.share_name
      }
      caddy-config = {
        mount_path = "/etc/caddy"
        secret = {
          "Caddyfile" = local.caddyfile_base64_encoded
        }
      }
    }, var.caddy_container.volumes)
  })
}
