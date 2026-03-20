terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "github" {
  # Terraform leerá la variable de entorno GITHUB_TOKEN automáticamente
  owner = "aishadeltio13"
}