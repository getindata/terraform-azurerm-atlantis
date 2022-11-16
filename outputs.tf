output "container_group_id" {
  description = "ID of the container group"
  value       = module.azure_container_group.id
}

output "container_group_name" {
  description = "Name of the container group"
  value       = module.azure_container_group.name
}

output "atlantis_webhook_url" {
  description = "Url of the Atlantis webhook used by git platforms like GitLab or GitHub"
  value       = format("http://%s:%s/events", module.azure_container_group.fqdn, var.port)
}
