output "endpoint_created" {
  value       = aws_dax_cluster.cluster.cluster_address
  description = "Endpoint of the DaX cluster."
}
