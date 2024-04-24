variable "aws_region" {
  description = "AWS region for the resources"
  type        = string
  default     = "eu-west-1" 
}

variable "endpoint" {
  description   = "Localstack endpoint"
  type          = string
  default       = "http://localhost:4566"
}