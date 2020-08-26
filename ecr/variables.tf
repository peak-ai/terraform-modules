variable "name" {
  type        = string
  description = "Name of ECR bucket"
}

variable "image_tag_mutability" {
  type    = string
  default = "MUTABLE"
}

variable "scan_on_push" {
  type    = bool
  default = true
}

variable "untagged_images_to_keep" {
  type    = number
  default = 5
}

variable "tags" {
  type        = object
  description = "Tags to pass"
}
