
terraform {
    backend "gcs" {
      bucket = "my-dev-storage"   
      prefix = "terraform/state"
    }
}
