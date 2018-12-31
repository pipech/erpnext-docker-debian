#!/bin/bash

echo "# waiting for container to start"
sleep 120s

echo "# debug"
echo "## docker logs"
docker logs "${docker_container_name}"
echo "## docker inspect"
docker inspect "${docker_container_name}"

echo "# test html response"
html_response = $(docker exec "${docker_container_name}" python test_server.py)
echo "${html_response}"

echo "# remove container"
docker rm -f "${docker_container_name}"

echo "# push image"
if [ "${html_response}" == "200" ]; then
    docker push "${docker_img}:${docker_img_tag}"

else
    echo "ERROR! : Html reponse is '${html_response}' not 200"
    exit 1
fi
