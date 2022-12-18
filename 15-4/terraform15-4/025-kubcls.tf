resource "yandex_kubernetes_cluster" "kub-reg-cls-1" {
  name        = "kub-cls-1"
  description = "Regional kub cluster"

  network_id = "${yandex_vpc_network.netology-net.id}"

  master {
    regional {
      region = "ru-central1"

      location {
        zone      = "${yandex_vpc_subnet.public-1.zone}"
        subnet_id = "${yandex_vpc_subnet.public-1.id}"
      }

      location {
        zone      = "${yandex_vpc_subnet.public-2.zone}"
        subnet_id = "${yandex_vpc_subnet.public-2.id}"
      }

      location {
        zone      = "${yandex_vpc_subnet.public-3.zone}"
        subnet_id = "${yandex_vpc_subnet.public-3.id}"
      }

    }

    version   = "1.22"
    public_ip = true

    maintenance_policy {
      auto_upgrade = true

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

  service_account_id      = "${yandex_iam_service_account.serviceacc2.id}"
  node_service_account_id = "${yandex_iam_service_account.serviceacc2.id}"


  release_channel = "STABLE"
  network_policy_provider = "CALICO"
  
  kms_provider {
    key_id = "${yandex_kms_symmetric_key.key-kub-cls.id}"
  }


}
