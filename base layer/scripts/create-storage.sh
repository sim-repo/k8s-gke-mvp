#!/bin/bash


echo -e "
provider google {
  version = \"$1\"
  project = \"$2\"
  region  = \"$3\"
  zone    = \"$4\"
  credentials = file(\"../../access-key.json\")
}

resource \"google_storage_bucket\" \"$5\" {
  name     = \"$5\"
  location = \"$3\"
}
" >./storage/main.tf