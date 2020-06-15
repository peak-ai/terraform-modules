output "image" {
  value       = "${var.repository_url}:${module.git_sha.stdout}"
  description = "The full path to the docker image"
}

output "tags" {
  value       = coalesce(local.tag, local.extra_tags...)
  description = "The image tags that have been built"
}
