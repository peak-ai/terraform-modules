variable "name" {
  type        = string
  description = "Name of S3 bucket"
}

variable "acl" {
  type    = string
  default = "bucket-owner-full-control"
}

variable "enable_versioning" {
  type    = bool
  default = false
}

variable "block_public_acls" {
  type    = bool
  default = true
}

variable "block_public_policy" {
  type    = bool
  default = true
}

variable "ignore_public_acls" {
  type    = bool
  default = true
}

variable "restrict_public_buckets" {
  type    = bool
  default = true
}

variable "tags" {
  description = "Tags to pass"
}
