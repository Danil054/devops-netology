resource "yandex_vpc_route_table" "private-route" {
  network_id = "${yandex_vpc_network.netology-net.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "${yandex_compute_instance.vm-nat.network_interface.0.ip_address}"
  }
}


