locals {
  folder_id = "b1gqcqnmiduqna3uc4e6"
}

# Create SA
resource "yandex_iam_service_account" "serviceacc1" {
  folder_id = local.folder_id
  name      = "svcacc1-s3"
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "setrole1" {
  folder_id = local.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.serviceacc1.id}"
}

#resource "yandex_resourcemanager_folder_iam_member" "setrole2" {
#  folder_id = local.folder_id
#  role      = "kms.keys.encrypterDecrypter"
#  member    = "serviceAccount:${yandex_iam_service_account.serviceacc1.id}"
#}


# Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "serviceacc1-static-key" {
  service_account_id = yandex_iam_service_account.serviceacc1.id
  description        = "static access key for object storage"
}


# Use keys to create bucket
resource "yandex_storage_bucket" "dan054s3-bk" {
  access_key = yandex_iam_service_account_static_access_key.serviceacc1-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.serviceacc1-static-key.secret_key
  bucket = "dan054s3-bucket"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-s3-dan054s3-bk.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# Add image
resource "yandex_storage_object" "load-picture" {
  bucket = yandex_storage_bucket.dan054s3-bk.bucket
  key    = "img1.png"
  source = "./img/hello.png"
  access_key = yandex_iam_service_account_static_access_key.serviceacc1-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.serviceacc1-static-key.secret_key
  acl = "public-read"
}
