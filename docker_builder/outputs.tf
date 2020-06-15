output "image" {
  value       = "${local.registry}:${module.git_sha.stdout}"
  description = "The full path to the docker image"
}
