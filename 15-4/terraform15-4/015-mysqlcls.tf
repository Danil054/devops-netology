resource "yandex_mdb_mysql_cluster" "mysql-cls-1" {
  name        = "mysql-cls-dan054"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.netology-net.id
  deletion_protection = "true"
  version     = "8.0"

  resources {
    resource_preset_id = "b1.medium" #https://cloud.yandex.ru/docs/managed-postgresql/concepts/instance-types
    disk_type_id       = "network-ssd"
    disk_size          = 20
  }

  maintenance_window {
    type = "ANYTIME"
  }

  backup_window_start {
    hours = "23"
    minutes = "59"
  }

  host {
    zone      = "ru-central1-a"
    name      = "mysql-node-1"
    subnet_id = yandex_vpc_subnet.private-1.id
  }

  host {
    zone                    = "ru-central1-b"
    name                    = "mysql-node-2"
    replication_source_name = "mysql-node-1"
    subnet_id               = yandex_vpc_subnet.private-2.id
  }

}

resource "yandex_mdb_mysql_database" "netology_db-1" {
  cluster_id = yandex_mdb_mysql_cluster.mysql-cls-1.id
  name       = "netology_db"
}

resource "yandex_mdb_mysql_user" "user-1" {
    cluster_id = yandex_mdb_mysql_cluster.mysql-cls-1.id
    name       = "user1"
    password   = "QhsD10Bnc"

    permission {
      database_name = yandex_mdb_mysql_database.netology_db-1.name
      roles         = ["ALL"]
    }

    connection_limits {
      max_questions_per_hour   = 10
      max_updates_per_hour     = 20
      max_connections_per_hour = 30
      max_user_connections     = 40
    }

    global_permissions = ["PROCESS"]

    authentication_plugin = "SHA256_PASSWORD"
}
