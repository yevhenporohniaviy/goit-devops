variable "ecr_name" {
  type        = string
  description = "Name of the ECR repository"
}

variable "scan_on_push" {
  type        = bool
  default     = false
  description = "Enable scanning images on push"
}
