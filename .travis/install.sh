#!/bin/bash

set -e
set -x

# define image abbreviation
## python
python_version_trailing="${python_version: -1}"
if [ python_version_trailing == "n" ]; then
    python_abbr="py2"
elif [ python_version_trailing == "3" ]; then
    python_abbr="py3"
else
    echo "ERROR! : Python version error"
    exit 1
fi
## branch
branch_abbr="${app_branch::3}"

# define image tag and container
docker_img_tag="${branch_abbr}-${python_abbr}-latest"
docker_container_name="${branch_abbr}-${python_abbr}-latest"

# build image
docker build -t ${docker_img}:${docker_img_tag} \
    --no-cache \
    --build-arg pythonVersion=${python_version} \
    --build-arg appBranch=${app_branch} \
    .
