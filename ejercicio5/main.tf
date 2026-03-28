resource "google_storage_bucket" "sample-element-aishadeltio" {
  name = "sample-element-aishadeltio"
  location = "europe-west1"
  storage_class = "STANDARD"
  force_destroy = true
}

resource "google_compute_instance" "virtualmachine_instance" {
  name             = "virtualmachine"
  zone             = "europe-southwest1-a"
  machine_type     = "e2-micro"
   
   boot_disk {
     initialize_params {
     image = "debian-cloud/debian-11"
     }
    }

    network_interface {
      network = "default"
    }
}


resource "google_cloud_run_v2_service" "cloudrun_service" {
  name     = "cloudrun-service"
  location = "europe-southwest1"
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"

  scaling {
    max_instance_count = 1
  }

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}

resource "google_cloud_run_v2_service" "cloudrun_manual" {
  name     = "hello"
  location = "europe-southwest1"

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}