#!/bin/bash

echo "# build image"
docker build -t "${docker_img}:${docker_img_tag}" \
    --no-cache \
    --build-arg pythonVersion="${python_version}" \
    --build-arg appBranch="${app_branch}" \
    .
