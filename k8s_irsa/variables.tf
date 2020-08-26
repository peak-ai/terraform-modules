variable "cluster" {
  type        = string
  description = "Name of K8S cluster"
}

variable "namespace" {
  type        = string
  description = "K8S namespace (should already exist)"
}

variable "service_account" {
  type        = string
  description = "Service account that will be attached to IAM role. Should not exist already"
}

variable "role_name" {
  type        = string
  description = "Name of IAM role. If not passed, will be generated randomly at runtime"
  default     = ""
}

variable "policy_name" {
  type        = string
  description = "Name of policy. If not passed, will be generated randomly at runtime"
  default     = ""
}

variable "policy_doc" {
  type        = string
  description = "The inline policy document. This is a JSON formatted string."
}

variable "tags" {
  description = "Tags to pass"
}
