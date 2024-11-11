terraform {
  required_version = ">= 0.13.1"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 3.4"
    }
  }
}
