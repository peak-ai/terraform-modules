variable "tags" {}

variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "node_type" {
  type    = string
  default = "dax.t2.small"
}

variable "replication_factor" {
  type    = number
  default = 3
}

variable "vpc_id" {
  type = string
}

variable "tables" {
  type = list(string)
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
