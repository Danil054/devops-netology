resource "yandex_compute_instance_group" "web-group1" {
  name                = "web-ig"
  folder_id           = "b1gqcqnmiduqna3uc4e6"
  service_account_id  = "aje1ur1gelphqguqgokf"
  deletion_protection = false
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.netology-net.id}"
      subnet_ids = ["${yandex_vpc_subnet.public.id}"]
      nat = false
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa-yc.pub")}"
      user-data = file("./initcloudcfg.yaml")
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
}
