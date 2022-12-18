resource "yandex_vpc_network" "netology-net" {
  name = "netology-network"
}

resource "yandex_vpc_subnet" "public-1" {
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.netology-net.id}"
}

resource "yandex_vpc_subnet" "public-2" {
  v4_cidr_blocks = ["192.168.11.0/24"]
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.netology-net.id}"
}

resource "yandex_vpc_subnet" "public-3" {
  v4_cidr_blocks = ["192.168.12.0/24"]
  zone           = "ru-central1-c"
  network_id     = "${yandex_vpc_network.netology-net.id}"
}

resource "yandex_vpc_subnet" "private-1" {
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.netology-net.id}"
}

resource "yandex_vpc_subnet" "private-2" {
  v4_cidr_blocks = ["192.168.21.0/24"]
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.netology-net.id}"
}


