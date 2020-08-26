output "default" {
  value = local.tags
}

output "string" {
  value = local.strigifiedTags
}

output "stage" {
  value = var.stage
}

output "tenant" {
  value = var.tenant
}

output "feature" {
  value = var.feature
}

output "service" {
  value = var.service
}
