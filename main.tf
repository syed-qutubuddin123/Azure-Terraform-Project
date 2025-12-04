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
