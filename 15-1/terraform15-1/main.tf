terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"       
#  token = ""     IN ENV YC_TOKEN
#  cloud_id = ""  IN ENV YC_CLOUD_ID
#  folder_id = "" IN ENV YC_FOLDER_ID
}


