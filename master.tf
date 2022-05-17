
# Defining master Node 01
# Use CloudInit to add the instance
resource "libvirt_cloudinit_disk" "test-k8s-master-01-commoninit" {
  name = "test-k8s-master-01-commoninit.iso"
  pool = "default"
  user_data      = "${data.template_file.user_data.rendered}"
}

## Defining VM Volume 01
resource "libvirt_volume" "test-k8s-master-01-qcow2" {
  name = "test-k8s-master-01.qcow2"
  pool = "default"
  source = "https://dl.rockylinux.org/pub/rocky/8.6/images/Rocky-8-GenericCloud.latest.x86_64.qcow2"
  format = "qcow2"
}

# Define KVM domain to create 01
resource "libvirt_domain" "test-k8s-master-01" {
  name   = "test-k8s-master-01"
  memory = "2048"
  vcpu   = 2

    network_interface {
      network_name = "test-k8s"
      network_id     = libvirt_network.test-k8s.id
      hostname       = "test-k8s-master-01"
      addresses = ["10.0.1.1"]
      wait_for_lease = false
    }

    disk {
      volume_id = "${libvirt_volume.test-k8s-master-01-qcow2.id}"
    }

    cloudinit = "${libvirt_cloudinit_disk.test-k8s-master-01-commoninit.id}"

    console {
      type = "pty"
      target_type = "serial"
      target_port = "0"
    }

    graphics {
      type = "spice"
      listen_type = "address"
      autoport = true
    }
}


