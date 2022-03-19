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

resource "yandex_compute_image" "deb-11-img" {
  name       = "deb-11"
  source_image = "fd8iea4hktad0qe0nogj"
}

resource "yandex_compute_instance" "vm1-deb-id" {
  name = "vm1-deb"



  boot_disk {
    initialize_params {
      image_id = "${yandex_compute_image.deb-11-img.id}"
    }
  }
}
