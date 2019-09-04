terraform {
  # Specify terraform code version
  required_version = ">=0.11.7"

#  # Specify Google provider version
#  required_providers = {
#    gcp = ">=2.1.0"
#  }
}

provider "google" {
 credentials = "project-factory-251914-dd3a3588898f.json"
 #project     = "terraform-246417"
 region      = "us-central1"
}

provider "google-beta" {
 credentials = "project-factory-251914-dd3a3588898f.json"
 #project     = "terraform-5246417"
 region      = "us-central1"
}
