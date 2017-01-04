#!/bin/bash
# Source: https://github.com/jecnua/terraform-module-generator
# Owner: jecnua <fabrizio.sabatini.it@gmail.com>
# License: MIT
# Usage:
# ./add_module.sh elasticsearch

MODULE_NAME="$2"

cd $1 || exit
cd modules || exit
mkdir $MODULE_NAME
cd $MODULE_NAME || exit

touch 'CHANGELOG.md'
touch '.gitignore'

mkdir 'graphs'
touch 'graphs/.gitignore'
mkdir 'images'
touch 'images/.gitignore'
mkdir 'scripts'
touch 'scripts/.gitignore'

cat << 'EOF' > 00-provider.tf
provider "aws" {
  region     = "${var.network_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}
EOF

touch '00-variables_defaults.tf'

cat << EOF > 00-variables_required_inputs.tf
variable "access_key" {}
variable "secret_key" {}
variable "network_region" {}
EOF

touch '00-outputs.tf'

rm -fr graphs/*
terraform get
terraform graph > graphs/overview.dot
dot -Tpng -o graphs/overview.png graphs/overview.dot
echo "graph generated"

terraform-docs md `pwd` >> `pwd`/params.md

cat << 'EOF' > README.md
# Module
![Overview](graphs/overview.png)

## Parameters

You can find them [here](params.md)

EOF

echo "Done"
