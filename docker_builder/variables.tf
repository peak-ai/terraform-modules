variable "repository_url" {
  type        = string
  description = "URL of the ECR repository"
}

variable "region" {
  type        = string
  description = "The AWS region to use"
}

variable "dockerfile" {
  type        = string
  description = "Location of Dockerfile"
}

variable "args" {
  type        = list(string)
  description = "A key value list of additional arguments to be passed into the docker build"
  default     = []
}

