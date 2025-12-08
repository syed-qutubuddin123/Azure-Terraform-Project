module "RG" {
  source = "./modules/RG"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = module.RG.resource_group_name
  location            = var.location
}

module "vm" {
  source              = "./modules/vm"
  servers             = var.servers
  location            = var.location
  resource_group_name = module.RG.resource_group_name
  subnet_id           = module.network.subnet_id
}

module "lb" {
  source              = "./modules/lb"
  environment         = terraform.workspace
  location            = var.location
  resource_group_name = module.RG.resource_group_name
  vm_nic_ids          = module.vm.vm_nic_ids
}

module "dns" {
  source              = "./modules/dns"
  resource_group_name = module.RG.resource_group_name
  domain_name         = "success.com"
  environment         = terraform.workspace
  vm_private_ips      = var.vm_private_ips
  vnet_id             = module.network.vnet_id
}

