variable "tags" {}

variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "node_type" {
  type        = string
  default     = "dax.t2.small"
  description = "(Required) The compute and memory capacity of the nodes"
}

variable "replication_factor" {
  type        = number
  default     = 3
  description = "(Required) The number of nodes in the DAX cluster"
}

variable "vpc_id" {
  type = string
}

variable "tables" {
  type        = list(string)
  description = "List of tables for using dax"
}

variable "item_cache_ttl_milli_second" {
  type        = number
  default     = 300000
  description = "Time after which item cache will invalidate. Default 5 minutes"
}

variable "query_cache_ttl__milli_second" {
  type        = number
  default     = 300000
  description = "Time after which query cache will invalidate. Default 5 minutes"
}

variable "security_group_ids" {
  type        = list(string)
  description = "(Required) One or more VPC security groups associated with the cluster"
}
