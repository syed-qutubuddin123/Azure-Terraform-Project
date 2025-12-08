resource "azurerm_private_dns_zone" "syed" {
  name                = var.domain_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_a_record" "records" {
  for_each            = var.vm_private_ips
  name                = "${each.key}.${var.environment}"
  zone_name           = azurerm_private_dns_zone.syed.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [each.value]
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "syed-link"
  private_dns_zone_name = azurerm_private_dns_zone.syed.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.vnet_id
}
