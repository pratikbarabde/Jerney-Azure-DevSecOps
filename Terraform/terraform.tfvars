resource_group_name = "aks-dev-rg"
location            = "East US"

cluster_name        = "jerney-aks"
kubernetes_version  = "1.34.3"

node_count = 2
vm_size    = "standard_d2s_v3"

vnet_cidr  = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"