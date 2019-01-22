#!/bin/bash

echo "# starting container"
docker run -d -p 8000:8000 -p 9000:9000 --name "${docker_container_name}" "${docker_img}:${docker_img_tag}"

echo "# waiting for container to start"
sleep 180s

echo "# debug"
echo "## docker list"
docker ps -a
echo "## docker logs"
docker logs "${docker_container_name}"
echo "## docker inspect"
docker inspect "${docker_container_name}"

echo "# test html response"
html_response=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8000)
echo "Html Response: ${html_response}"

echo "# remove container"
docker rm -f "${docker_container_name}"

echo "# push image"
if [ "${html_response}" == "200" ]; then
    docker push "${docker_img}:${docker_img_tag}"
else
    echo "ERROR! : Html reponse is '${html_response}' not 200"
    exit 1
fi
