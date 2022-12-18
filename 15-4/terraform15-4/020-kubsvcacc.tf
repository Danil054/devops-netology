locals {
  folder_id = "b1gqcqnmiduqna3uc4e6"
}

# Create SA
resource "yandex_iam_service_account" "serviceacc2" {
  folder_id = local.folder_id
  name      = "svcacc2-kub"
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "setrole1" {
  folder_id = local.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.serviceacc2.id}"
}

#resource "yandex_resourcemanager_folder_iam_member" "setrole2" {
#  folder_id = local.folder_id
#  role      = "k8s.admin"
#  member    = "serviceAccount:${yandex_iam_service_account.serviceacc2.id}"
#}

#resource "yandex_resourcemanager_folder_iam_member" "setrole3" {
#  folder_id = local.folder_id
#  role      = "kms.keys.encrypterDecrypter"
#  member    = "serviceAccount:${yandex_iam_service_account.serviceacc2.id}"
#}

