locals {
  # Get a name from the descriptor. If not available, use default naming convention.
  # Trim and replace function are used to avoid bare delimiters on both ends of the name and situation of adjacent delimiters.
  name_from_descriptor = trim(replace(
    lookup(module.this.descriptors, "azure-container-group", module.this.id),
    "/${module.this.delimiter}${module.this.delimiter}+/",
  module.this.delimiter), module.this.delimiter)

  location            = coalesce(one(data.azurerm_resource_group.this[*].location), var.location)
  resource_group_name = coalesce(one(data.azurerm_resource_group.this[*].name), var.resource_group_name)

  dns_name_label = (length(var.subnet_ids) == 0
    ? (var.dns_name_label != null ? var.dns_name_label : local.name_from_descriptor)
  : null)
  hostname = coalesce(var.hostname, format(
    "%s.%s.azurecontainer.io",
    local.dns_name_label,
    local.location
  ))

  caddy_container = merge(var.caddy_container, {
    commands = ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
    volumes = {
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