
provider google {
  version = "3.5.0"
  project = "alpine-realm-270323"
  region  = "us-east1"
  zone    = "us-east1-a"
}

resource "google_storage_bucket" "my-prod-storage" {
  name     = "my-prod-storage"
  location = "us-east1"
}

