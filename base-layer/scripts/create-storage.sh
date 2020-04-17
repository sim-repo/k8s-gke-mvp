#!/bin/sh

cur_environment=$1



if [[ "$cur_environment" == "dev" ]]; then
echo "
provider google {
  version = \"$2\"
  project = \"$3\"
  region  = \"$4\"
  zone    = \"$5\"
}

resource \"google_storage_bucket\" \"$6\" {
  name     = \"$6\"
  location = \"$4\"
  #storage_class = \"regional\"
  force_destroy = true
}
" >./storage/dev/main.tf
fi


if [[ "$cur_environment" == "prod" ]]; then
  echo "
provider google {
  version = \"$2\"
  project = \"$3\"
  region  = \"$4\"
  zone    = \"$5\"
}

resource \"google_storage_bucket\" \"$6\" {
  name     = \"$6\"
  location = \"$4\"
}
" >./storage/prod/main.tf
fi
