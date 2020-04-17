
terraform {
    backend "gcs" {
      bucket = "my-prod-storage"   
      prefix = "terraform/state"
    }
}
