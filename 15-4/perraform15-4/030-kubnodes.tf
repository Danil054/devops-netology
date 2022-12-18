resource "yandex_kubernetes_node_group" "nodes_group" {
  cluster_id  = "${yandex_kubernetes_cluster.kub-reg-cls-1.id}"
  name        = "nodes-group-1"
  description = "description"
  version     = "1.22"

  instance_template {
    platform_id = "standard-v2"
    
    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa-yc.pub")}"
    }

    network_interface {
      nat                = true
#      subnet_ids         = ["${yandex_vpc_subnet.public-1.id}", "${yandex_vpc_subnet.public-2.id}", "${yandex_vpc_subnet.public-3.id}"]
      subnet_ids         = ["${yandex_vpc_subnet.public-1.id}"]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    auto_scale {
      min = 3
      max = 6
      initial = 3
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }

#IF auto_scale THEN only one location
 
#    location {
#      zone = "ru-central1-b"
#    }
#    location {
#      zone = "ru-central1-c"
#    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }

}
