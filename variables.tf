# ! ============ AWS Setup ============
variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "aws_credentials_path" {
  description = "Path to aws credentials file"
  type        = string
  default     = "$HOME/.aws/credentials"
}
