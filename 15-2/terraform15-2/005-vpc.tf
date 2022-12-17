resource "yandex_vpc_network" "netology-net" {
  name = "netology-network"
}

resource "yandex_vpc_subnet" "public" {
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = "${yandex_vpc_network.netology-net.id}"
}

resource "yandex_vpc_subnet" "private" {
  v4_cidr_blocks = ["192.168.20.0/24"]
  network_id     = "${yandex_vpc_network.netology-net.id}"
  route_table_id = "${yandex_vpc_route_table.private-route.id}"
}


