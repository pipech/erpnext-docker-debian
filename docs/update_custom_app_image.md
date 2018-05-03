---
layout: page
title: Update ERPNext image with custom apps
permalink: /update_custom_app_image/
---

* In production_setup

    `docker build . --no-cache`
    
* Get latest  image id

    `docker images`
  
* Tag image

    `docker tag <image_id> <docker_hub_username>/<docker_hub_repo_name>:<tag>`
    
* Update frappe service

    `docker service update --image <docker_hub_username>/<docker_hub_repo_name>:<tag> <stack_name>_frappe`

* Call bash in frappe container

    `docker exec -it <frappe_container_id> bash`
    
* Update database and build js and css

    `bench update --patch && bench update --build`