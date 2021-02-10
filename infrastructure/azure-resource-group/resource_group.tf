provider "azurerm" {
  version = "~>2.0"
  features {}
}

provider "hcs" { }

resource "azurerm_resource_group" "us_west_1" {
  name     = "hcs-ignite-us-west-1"
  location = "westus1"
}

resource "azurerm_resource_group" "us_west_2" {
  name     = "hcs-ignite-us-west-2"
  location = "westus2"
}