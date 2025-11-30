variable "location" {
  default = "South India"
}

variable "resource_group_name" {
  default = "my_rg"
}

variable "servers" {
  default = {
    server1 = "Standard_B1s"
    server2 = "Standard_B1s"
  }
}
