variable "repository_url" {
  type        = string
  description = "URL of the ECR repository"
}

variable "region" {
  type        = string
  description = "The AWS region to use"
}

variable "path" {
  type        = string
  description = "Path where the dockerfile exists"
}

variable "args" {
  type        = list(string)
  description = "A key value list of additional arguments to be passed into the docker build"
  default     = []
}

variable "git_branch" {
  type        = string
  description = "The git branch"
}

variable "git_sha" {
  type        = string
  description = "The SHA of the git commit"
}

