output "container_group_id" {
  description = "ID of the container group"
  value       = module.this_atlantis.container_group_id
}

output "container_group_name" {
  description = "Name of the container group"
  value       = module.this_atlantis.container_group_name
}

output "container_group_resource_group_name" {
  description = "Name of the container group resource group"
  value       = module.this_atlantis.container_group_resource_group_name
}

output "container_group_system_assigned_identity_principal_id" {
  description = "ID of the system assigned principal"
  value       = module.this_atlantis.container_group_system_assigned_identity_principal_id
}

output "container_group_fqdn" {
  description = "The FQDN of the container group derived from `dns_name_label`"
  value       = module.this_atlantis.container_group_fqdn
}

output "container_group_ip_address" {
  description = "The IP address allocated to the container group"
  value       = module.this_atlantis.container_group_ip_address
}
