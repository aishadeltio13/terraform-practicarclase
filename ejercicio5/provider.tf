terraform {
  backend "gcs" {
    bucket  = "terraform_aishadeltio"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = "terraform-pedro"
  region  = "europe-southwest1"
}