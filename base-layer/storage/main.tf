
provider google {
  version = "3.5.0"
  project = "alpine-realm-270323"
  region  = "us-central1"
  zone    = "us-central1-c"
  #credentials = file("../../access-key.json")
}

resource "google_storage_bucket" "my-dev-storage" {
  name     = "my-dev-storage"
  location = "us-central1"
}

