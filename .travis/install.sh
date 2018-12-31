#!/bin/bash

# define image abbreviation
## python
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

## branch
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

# run container
docker run -d -p 8000:8000 -p 9000:9000 --name "${docker_container_name}" "${docker_img}:${docker_img_tag}"

# waiting for container to start
sleep 120s

# debug
## docker logs
docker logs "${docker_container_name}"
## docker inspect
docker inspect "${docker_container_name}"

# test html response
html_response = $(docker exec "${docker_container_name}" python test_server.py)
echo "${html_response}"

# remove container
docker rm -f "${docker_container_name}"

# push image
if [ "$html_response" == "200" ]; then
    docker push "${docker_img}:${docker_img_tag}"
else
    echo "ERROR! : Html reponse is not 200"
    exit 1
fi
