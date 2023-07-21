# variables.tf

variable "container_image" {
  description = "The URL of your container image"
  type        = string
  default     = "your-container-registry-url/your-container-image:latest"
}
