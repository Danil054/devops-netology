resource "yandex_kms_symmetric_key" "key-s3-dan054s3-bk" {
  name              = "key-s3-dan054s3-bucket"
  description       = "key for s3 backet dan054s3-bucket"
  default_algorithm = "AES_256"
}
