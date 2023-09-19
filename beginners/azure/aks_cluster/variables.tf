#Variable
# variable "client_id" {}

# variable "client_secret" {}

# variable "subscription_id" {}

# variable "tenant_id" {}

# variable "location" {}

variable "cluster_name" {
    default = "test-cluster-1069256"
}

variable "dns_prifix" {
    default = "test-dns-prefix-1069256"
}

# variable "resource_group_name" {}

variable "log_analytics_workspace_name" {
    default = "test-log-analytics-workspace-1069256"
}

variable "log_analytics_workspace_location" {
    default = "eastus"
}
variable "log_analytics_workspace_sku" {
    default = "PerNode"
}

