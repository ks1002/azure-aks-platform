terraform {
  backend "azurerm" {
    resource_group_name  = "rg-aksplatform-dev-ne-tfstate"
    storage_account_name = "youruniquestorageaccount"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"

    use_azuread_auth = true
    use_cli          = true
  }
}
