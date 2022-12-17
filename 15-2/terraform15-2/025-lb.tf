resource "yandex_lb_target_group" "lb-web-group" {
  name      = "lb-web-group-1"
  region_id = "ru-central1"

  target {
    subnet_id = "${yandex_vpc_subnet.public.id}"
    address   = "${yandex_compute_instance_group.web-group1.instances[0].network_interface[0].ip_address}"
  }
  target {
    subnet_id = "${yandex_vpc_subnet.public.id}"
    address   = "${yandex_compute_instance_group.web-group1.instances[1].network_interface[0].ip_address}"
  }
  target {
    subnet_id = "${yandex_vpc_subnet.public.id}"
    address   = "${yandex_compute_instance_group.web-group1.instances[2].network_interface[0].ip_address}"
  }

}

resource "yandex_lb_network_load_balancer" "lb-web" {
  name = "lb-web-1"

  listener {
    name = "lb-web"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.lb-web-group.id}"

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/index.html"
      }
    }
  }
}
