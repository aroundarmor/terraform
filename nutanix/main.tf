# Defining the auth and connection block
terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "1.4.1"
    }
  }
}

#declaring provider

provider "nutanix" {
  username     = var.creds["user"]
  password     = var.creds["pass"]
  endpoint     = "10.10.20.100"
  port         = "9440"
  insecure     = true
  wait_timeout = 10
}

#fetching data
data "nutanix_subnet" "subnet" {
  subnet_name = "LAN0"
}

# fetching vm image
# to do: create an image of running vm so that everytime we spun up we get server ready to go

resource "nutanix_image" "ubuntu" {
  name        = "Ubuntu"
  description = "Ubuntu"
  source_uri  = "https://releases.ubuntu.com/18.04/ubuntu-18.04.6-desktop-amd64.iso"
}

#creating vm
resource "nutanix_virtual_machine" "vm" {
  name                 = "Terraform101"
  cluster_uuid         = "0006c84b-2146-de7a-62a9-0cc93sc8fe3b"
  num_vcpus_per_socket = "2"
  num_sockets          = "1"
  memory_size_mib      = "4096"
  
#adding disk
  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.ubuntu.id
    }
  }

  disk_list {
    disk_size_mib = 65000
    device_properties {
      device_type = "DISK"
      disk_address = {
        "adapter_type" = "SCSI"
        "device_index" = "1"
      }
    }
  }

#adding network card
  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }
}