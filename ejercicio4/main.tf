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

resource "google_compute_instance" "manualterraform" {
  name         = "manual"
  zone         = "europe-southwest1-b"
  machine_type = "e2-micro"

  key_revocation_action_type = "NONE"

  metadata = {
    "enable-osconfig" = "TRUE"
  }

  boot_disk {
    initialize_params {
      image = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-12-bookworm-v20260310"
      size  = 10
      type  = "pd-balanced"
      resource_policies = [
        "https://www.googleapis.com/compute/v1/projects/terraform-pedro/regions/europe-southwest1/resourcePolicies/default-schedule-1",
      ]
    }
  }

  network_interface {
    network = "https://www.googleapis.com/compute/v1/projects/terraform-pedro/global/networks/default"

    access_config {
      nat_ip       = "34.175.171.34"
      network_tier = "PREMIUM"
    }
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email = "581467562752-compute@developer.gserviceaccount.com"
    scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }
  
  reservation_affinity {
    type = "ANY_RESERVATION"
  }
}