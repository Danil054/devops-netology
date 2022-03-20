terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  #token     = "" IN ENV YC_TOKEN
  #cloud_id  = "" IN ENV YC_CLOUD_ID
  #folder_id = "" IN ENV YC_FOLDER_ID
  #zone      = "" IN ENV YC_ZONE
}

locals {
  instance_count = {
    stage = 1
    prod = 2
  }

  virtuals = {
    "vm-deb-11-1" = "fd8iea4hktad0qe0nogj"
    "vm-deb-11-2" = "fd8iea4hktad0qe0nogj"
    "vm-deb-11-3" = "fd8iea4hktad0qe0nogj"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  #zone           = ""
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_compute_image" "deb-11-img" {
  name       = "deb-11"
  source_image = "fd8iea4hktad0qe0nogj"
}


resource "yandex_compute_instance" "vm-deb-id" {

  lifecycle {
    create_before_destroy = true
  }

  name = "vm-deb-11-${count.index}-${terraform.workspace}"

  count = local.instance_count[terraform.workspace]

  resources {
    cores  = 2
    memory = 2
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  boot_disk {
    initialize_params {
      image_id = "${yandex_compute_image.deb-11-img.id}"
    }
  }
}


resource "yandex_compute_instance" "vm-deb-id2" {

  lifecycle {
    create_before_destroy = true
  }

  for_each = local.virtuals

  name = each.key

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = each.value
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

}


output "internal_ip_address_vm_deb-id" {
  value = yandex_compute_instance.vm-deb-id[*].network_interface.0.ip_address
}

output "external_ip_address_vm_deb-id" {
  value = yandex_compute_instance.vm-deb-id[*].network_interface.0.nat_ip_address
}


