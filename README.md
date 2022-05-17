# Virtual machines for local Kubernetes test cluster

Terraform Provided Test Cluster. Provider is a Linux-based KVM / libvirt platform. One master and two worker nodes.

![terraform graph](graph.png)

## Links

### Installing KVM

- https://computingforgeeks.com/how-to-install-kvm-on-fedora/

### Installing terraform

- https://learn.hashicorp.com/tutorials/terraform/install-cli

## Provisioning

        git clone https://github.com/pasiol/tf-k8s-test-cluster.git
        cd tf-k8s-test-cluster
        terraform init
        terraform plan
        terraform graph -type=plan | dot -Tpng > graph.png
        terraform apply

