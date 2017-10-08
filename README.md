# Это инфраструктурный репозиторий
для ручного запуска скриптов:
* bash
* install_ruby обязательно от пользователя
* перезапустить сеанс консоли или в другом сеансе выполнять остальные скрипты
* install_mongodb от рута
* deploy от рута
---
# Скипт для создания и автоматической настройки виртуальной машниы с помощью Shell скрипта

```
gcloud compute instances create --boot-disk-size=10GB --image=ubuntu-1604-xenial-v20170815a --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --zone=europe-west1-b reddit-app --metadata-from-file startup-script=startup.sh reddit-app
```
