provider "google" {
  project = "infra-192502"

  region = "europe-west1"
}

resource "google_compute_instance" "app" {
  name = "reddit-app"
  machine_type = "g1-small"
  zone = "europe-west3-c"
  tags = ["reddit-app"]
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "reddit-base-1516246236"
    }
  }
  # определение сетевого интерфейса
  metadata {
    sshKeys = "appuser:${file("C:/Users/NKuzmin/.ssh/appuser.pub")}"
  }
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"
    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }
  connection {
    type = "ssh"
    user = "appuser"
    agent = false
    private_key = "${file("C:/Users/NKuzmin/.ssh/appuser")}"
  }
  provisioner "file" {
    source = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}
resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports = ["9292"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с тегом ...
  target_tags = ["reddit-app"]
}