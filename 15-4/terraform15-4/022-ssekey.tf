resource "yandex_kms_symmetric_key" "key-kub-cls" {
  name              = "key-kub-cls-1"
  description       = "key for kub cluster"
  default_algorithm = "AES_256"
}
