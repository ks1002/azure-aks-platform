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
  description = "Short name for Azure region"
  type        = string
  default     = "ne"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "aksplatform"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "app_vnet_address_space" {
  description = "Application VNet address space"
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "management_vnet_address_space" {
  description = "Management VNet address space"
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "firewall_subnet_address_prefixes" {
  description = "Azure Firewall subnet address range"
  type        = list(string)
  default     = ["10.10.1.0/26"]
}

variable "aks_subnet_address_prefixes" {
  description = "AKS subnet address range"
  type        = list(string)
  default     = ["10.10.2.0/23"]
}

variable "private_endpoint_subnet_address_prefixes" {
  description = "Private Endpoint subnet address range"
  type        = list(string)
  default     = ["10.10.4.0/24"]
}

variable "management_subnet_address_prefixes" {
  description = "Management subnet address range"
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "tags" {
  description = "Common Azure resource tags"
  type        = map(string)
  default     = {}
}
