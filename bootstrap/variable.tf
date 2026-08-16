variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "northeurope"
}

variable "location_short" {
  description = "Short Azure region code"
  type        = string
  default     = "ne"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "aksplatform"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Common Azure resource tags"

  type = map(string)

  default = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "AKSPlatform"
  }
}
