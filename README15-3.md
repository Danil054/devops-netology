## Задание 1. Яндекс.Облако  

Добавили изменения в манифесты для Terraform из прошлого задания [terraform files](https://github.com/Danil054/devops-netology/blob/main/15-3/terraform15-3/)  
Добавлено/изменено:  
- [012-ssekey.tf](https://github.com/Danil054/devops-netology/blob/main/15-3/terraform15-3/012-ssekey.tf):  
Создаём ключ шифрования  
- [015-s3.tf](https://github.com/Danil054/devops-netology/blob/main/15-3/terraform15-3/015-s3.tf):  
Добавлено шифрование бакета  
Единственное, я не смог задать две роли для сервисного аккаунта svcacc1-s3 через терраформ, не подскажете как?  
Пришлось в веб консоли Яндекса добавить к роли: storage.admin ещё роль kms.keys.encrypterDecrypter  





