provider "google" {
  project = "${var.project}"

  region = "${var.region}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  app_disk_image  = "${var.app_disk_image}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source          = "../modules/vpc"
  public_key_path = "${var.public_key_path}"

  source_ranges = [
    "0.0.0.0/0",
  ]
}

//    connection {
//      type        = "ssh"
//      user        = "appuser"
//      agent       = false
//      private_key = "${file(var.connection)}"
//    }
//
//    provisioner "file" {
//      source      = "files/puma.service"
//      destination = "/tmp/puma.service"
//    }
//
//    provisioner "remote-exec" {
//      script = "files/deploy.sh"
//    }
//  }

