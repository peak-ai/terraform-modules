variable "repository" {
  type        = string
  description = "URL of the ECR repository"
}

variable "service" {
  type        = string
  description = "Name of the service"
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

