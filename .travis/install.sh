#!/bin/bash

echo "# define image abbreviation"
echo "## python"
echo "python_version: ${python_version}"
python_version_trailing="${python_version: -1}"
echo "python_version_trailing: ${python_version_trailing}"
if [ "$python_version_trailing" == "n" ]; then
    python_abbr="py2"
elif [ "$python_version_trailing" == "3" ]; then
    python_abbr="py3"
else
    echo "ERROR! : Python version error"
    exit 1
fi
echo "python_abbr: ${python_abbr}"

echo "## branch"
echo "app_branch: ${app_branch}"
branch_abbr="${app_branch::3}"
echo "branch_abbr: ${branch_abbr}"

# define image tag and container
docker_img_tag="${branch_abbr}-${python_abbr}-latest"
docker_container_name="${branch_abbr}-${python_abbr}-latest"

# build image
docker build -t "${docker_img}:${docker_img_tag}" \
    --no-cache \
    --build-arg pythonVersion="${python_version}" \
    --build-arg appBranch="${app_branch}" \
    .
