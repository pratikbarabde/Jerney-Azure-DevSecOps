# -----------------------------
# Resource Group
# -----------------------------
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# -----------------------------
# Virtual Network
# -----------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.cluster_name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet_cidr]
}

# -----------------------------
# Subnet
# -----------------------------
resource "azurerm_subnet" "subnet" {
  name                 = "${var.cluster_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]
}

# -----------------------------
# AKS Cluster
# -----------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name

  kubernetes_version = var.kubernetes_version

  # 🔐 Identity (like IAM role)
  identity {
    type = "SystemAssigned"
  }

  # -----------------------------
  # Default Node Pool (System Pool)
  # -----------------------------
  default_node_pool {
    name       = "system"
    node_count = var.node_count
    vm_size    = var.vm_size

    vnet_subnet_id = azurerm_subnet.subnet.id

    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2

    type = "VirtualMachineScaleSets"
  }

  # -----------------------------
  # Networking (like EKS VPC CNI)
  # -----------------------------
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    service_cidr   = "10.2.0.0/16"   # ✅ FIXED (no overlap)
    dns_service_ip = "10.2.0.10"

  
  }

  # -----------------------------
  # RBAC
  # -----------------------------
  role_based_access_control_enabled = true

  # -----------------------------
  # Logging (Equivalent to EKS logs)
  # -----------------------------
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id
  }

  # -----------------------------
  # Security
  # -----------------------------
  azure_policy_enabled = true

  # -----------------------------
  # API Access
  # -----------------------------
  private_cluster_enabled = false # set true for prod
}

# -----------------------------
# Log Analytics Workspace
# -----------------------------
resource "azurerm_log_analytics_workspace" "log" {
  name                = "${var.cluster_name}-logs"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}