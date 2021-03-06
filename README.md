# Terraform module generator

This repo contains scripts to:

- Generate a new github module repo following terragrunt best practices
- Add a new module in an existing repo

## Requirements

- terraform
- [terraform-docs](https://github.com/segmentio/terraform-docs)

## Usage

### Create a new repo

    ./create_repo.sh <one> <two>

Will create a repo called tf-one-two.
So, for example:

    ./create_repo.sh aws elasticsearch

Will create a module called tf-aws-elasticsearch.

### Add a module to a repo

    ./add_module.sh <base_dir> <name>

Will add a module inside the modules directory of the <name> dir.
So, for example:

    ./add_module.sh tf-aws-elasticsearch elasticsearch

Will add a dir called elasticsearch inside the tf-aws-elasticsearch dir.
It will also generate the params.md file and the graph. All is linked from a
README.md created in the module directory.
