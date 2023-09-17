#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*          Host a Static Website on Azure Storage     *#
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

#
# - Provider Block
#

provider "azurerm" {
  features {}
}

#
# - Create a Resource Group
#

data "azurerm_resource_group" "rg" {
  name     = "ODL-azure-1069256"
}

#
# - Create a Random integer to append to Storage account name
#

resource "random_integer" "sa_name" {
  min = 1111
  max = 9999
  # Result will be like this - 1325
}

#
# - Create a Storage account with Network Rules
#

resource "azurerm_storage_account" "sa" {
  name                     = "${var.saVars["name"]}${random_integer.sa_name.result}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_kind             = var.saVars["account_kind"]
  account_tier             = var.saVars["account_tier"]
  access_tier              = var.saVars["access_tier"]
  account_replication_type = var.saVars["account_replication_type"]

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  tags = var.tags
}


resource "azurerm_storage_blob" "website" {
  for_each               = var.blobs
  name                   = each.key
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = each.value
}
