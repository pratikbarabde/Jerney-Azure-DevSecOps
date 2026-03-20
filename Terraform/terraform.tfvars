resource_group_name = "aks-dev-rg"
location            = "Central India"

cluster_name        = "jerney-aks"
kubernetes_version  = "1.29.0"

node_count = 2
vm_size    = "Standard_DS2_v2"

vnet_cidr  = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"