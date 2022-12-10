output "container_group_id" {
  description = "ID of the container group"
  value       = module.azure_container_group.id
}

output "container_group_name" {
  description = "Name of the container group"
  value       = module.azure_container_group.name
}

output "container_group_resource_group_name" {
  description = "Name of the container group resource group"
  value       = module.azure_container_group.resource_group_name
}

output "container_group_system_assigned_identity_principal_id" {
  description = "ID of the system assigned principal"
  value       = module.azure_container_group.system_assigned_identity_principal_id
}

output "container_group_fqdn" {
  description = "The FQDN of the container group derived from `dns_name_label`"
  value       = module.azure_container_group.fqdn
}

output "container_group_ip_address" {
  description = "The IP address allocated to the container group"
  value       = module.azure_container_group.ip_address
}
