locals {
  # Get a name from the descriptor. If not available, use default naming convention.
  # Trim and replace function are used to avoid bare delimiters on both ends of the name and situation of adjacent delimiters.
  name_from_descriptor = trim(replace(
    lookup(module.this.descriptors, "azure-container-group", module.this.id),
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

  caddy_container = merge(var.caddy_container, {
    commands = ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
    volumes = {
      caddy-data = {
        mount_path           = "/etc/caddy"
        storage_account_name = local.caddy_persistence_storage_account.name
        storage_account_key  = local.caddy_persistence_storage_account.key
        share_name           = local.caddy_persistence_storage_account.share_name
      }
      caddy-file = {
        mount_path = "/etc/caddy"
        secret = {
          "Caddyfile" = base64encode(templatefile("${path.module}/templates/Caddyfile.tpl", {
            hostname = local.hostname
          }))
        }
      }
    }
  })
}
