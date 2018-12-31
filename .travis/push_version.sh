#!/bin/bash

echo "# get version"
img_version_tag = $(python image_tag.py)
echo "${img_version_tag}"

if [ -z "${img_version_tag}" ]; then
      echo "# tagging image"
      docker tag "${docker_img}:${docker_img_tag}" "${docker_img}:${img_version_tag}"
fi
