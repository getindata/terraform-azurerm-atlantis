output "container_group_id" {
  description = "ID of the container group"
  value       = module.this_atlantis.container_group_id
}

output "container_group_name" {
  description = "Name of the container group"
  value       = module.this_atlantis.container_group_name
}

output "atlantis_url" {
  description = "Url for the Atlantis UI"
  value       = format("https://%s", local.hostname)
}

output "atlantis_webhook_url" {
  description = "Url of the Atlantis webhook used by git platforms like GitLab or GitHub"
  value       = format("https://%s/events", local.hostname)
}
