terraform {
  backend "local" {
  }
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_network" "test-k8s" {
  name      = "test-k8s"
  mode      = "nat"
  domain    = "k8s.local"
  addresses = ["10.0.0.0/8"]
  dns {
    enabled = true
    local_only = true
  }
  dhcp {
    enabled = false
  }
}