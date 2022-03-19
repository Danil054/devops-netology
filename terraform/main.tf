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

resource "yandex_compute_instance" "vm1-deb-id" {
  name = "vm1-deb"

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

output "internal_ip_address_vm1_deb" {
  value = yandex_compute_instance.vm1-deb-id.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm1-deb-id.network_interface.0.nat_ip_address
}

