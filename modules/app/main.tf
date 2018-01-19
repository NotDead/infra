resource "google_compute_instance" "app" {
  name = "reddit-app"
  machine_type = "g1-small"
  zone = "europe-west3-c"

  tags = [
    "reddit-app"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  # определение сетевого интерфейса
  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }

  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"

      # использовать ephemeral IP для доступа из Интернет
    }
  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports = [
      "9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = [
    "0.0.0.0/0"]

  # Правило применимо для инстансов с тегом ...
  target_tags = [
    "reddit-app"]
}