1.  

Зарегистрировался и ознакомился в яндекс облаке, ещё раньше, занятие было, так же установили CLI: yc  

2.  

terraform plan:  

```
root@vagrant:~/gitrepo/devops-netology/terraform# terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_image.deb-11-img will be created
  + resource "yandex_compute_image" "deb-11-img" {
      + created_at      = (known after apply)
      + folder_id       = (known after apply)
      + id              = (known after apply)
      + min_disk_size   = (known after apply)
      + name            = "deb-11"
      + os_type         = (known after apply)
      + pooled          = (known after apply)
      + product_ids     = (known after apply)
      + size            = (known after apply)
      + source_disk     = (known after apply)
      + source_family   = (known after apply)
      + source_image    = "fd8iea4hktad0qe0nogj"
      + source_snapshot = (known after apply)
      + source_url      = (known after apply)
      + status          = (known after apply)
    }

  # yandex_compute_instance.vm1-deb-id will be created
  + resource "yandex_compute_instance" "vm1-deb-id" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + name                      = "vm1-deb"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = (known after apply)
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + placement_group_id = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.network-1 will be created
  + resource "yandex_vpc_network" "network-1" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "network1"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet-1 will be created
  + resource "yandex_vpc_subnet" "subnet-1" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_vm_1    = (known after apply)
  + internal_ip_address_vm1_deb = (known after apply)

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```



Terraform apply:  

```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_compute_instance.vm1-deb-id: Creating...
yandex_compute_instance.vm1-deb-id: Still creating... [10s elapsed]
yandex_compute_instance.vm1-deb-id: Still creating... [20s elapsed]
yandex_compute_instance.vm1-deb-id: Creation complete after 30s [id=fhmca2adrosohd5ld0gb]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_vm_1 = "178.154.241.26"
internal_ip_address_vm1_deb = "192.168.10.27"
root@vagrant:~/gitrepo/devops-netology/terraform#
```

Создали ВМ из указанного образа.  
```
root@vagrant:~/gitrepo/devops-netology/terraform# yc compute  instance list
+----------------------+---------+---------------+---------+----------------+---------------+
|          ID          |  NAME   |    ZONE ID    | STATUS  |  EXTERNAL IP   |  INTERNAL IP  |
+----------------------+---------+---------------+---------+----------------+---------------+
| fhmca2adrosohd5ld0gb | vm1-deb | ru-central1-a | RUNNING | 178.154.241.26 | 192.168.10.27 |
+----------------------+---------+---------------+---------+----------------+---------------+

root@vagrant:~/gitrepo/devops-netology/terraform#
root@vagrant:~/gitrepo/devops-netology/terraform#
root@vagrant:~/gitrepo/devops-netology/terraform# yc compute  image list
+----------------------+--------+--------+----------------------+--------+
|          ID          |  NAME  | FAMILY |     PRODUCT IDS      | STATUS |
+----------------------+--------+--------+----------------------+--------+
| fd8dg97tsu0gv9pg8927 | deb-11 |        | f2eh0q405tdft5hl1b3d | READY  |
+----------------------+--------+--------+----------------------+--------+

root@vagrant:~/gitrepo/devops-netology/terraform#
```


Очистка, terraform destroy:  
```
Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

yandex_compute_instance.vm1-deb-id: Destroying... [id=fhmca2adrosohd5ld0gb]
yandex_compute_instance.vm1-deb-id: Still destroying... [id=fhmca2adrosohd5ld0gb, 10s elapsed]
yandex_compute_instance.vm1-deb-id: Destruction complete after 13s
yandex_compute_image.deb-11-img: Destroying... [id=fd8dg97tsu0gv9pg8927]
yandex_vpc_subnet.subnet-1: Destroying... [id=e9bsrc4b0ghagtk74srf]
yandex_vpc_subnet.subnet-1: Destruction complete after 7s
yandex_vpc_network.network-1: Destroying... [id=enpfceog6et8oph8k251]
yandex_vpc_network.network-1: Destruction complete after 1s
yandex_compute_image.deb-11-img: Destruction complete after 8s

Destroy complete! Resources: 4 destroyed.
root@vagrant:~/gitrepo/devops-netology/terraform#

```


