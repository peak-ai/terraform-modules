variable "stage" {
  description = "Stage on which infra should be deployed"
  type        = string
  validation {
    condition     = can(regex("latest|test|beta|prod|parvati", var.stage))
    error_message = "Invalid stage! Allowed values are [latest, test, beta, prod, parvati]."
  }
}

variable "tenant" {
  type    = string
  default = "platform"
}

variable "feature" {
  type = string
}

variable "service" {
  type = string
}
