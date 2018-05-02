---
layout: page
title: Create ERPNext image with custom apps
permalink: /create_custom_app_image/
---

* Fork this repository

* In production_setup/Dockerfile, in install custom app section there are 2 config uncommented config that suit your need,
then config file as describe below

    * Private Repository
    
        * Set git password in production_setup/Dockerfile
        
            ```
            ### PLEASE MAKE SURE YOUR REPOSITORY IN BOTH GITHUB AND DOCKERHUB IS SET TO PRIVATE
            ### WE'LL NOT HOLD RESPONSIBILITY FOR ANY PASSWORD LEAKED
            ENV git_password=your_git_password
            ```
    
        * Set git url and app name in production_setup/conf/frappe-custom-app/install_custom_app.sh
    
            `spawn bench get-app <your_app_name> <your_app_repo_url>`

    * Public Repository

        * Set app name and url in production_setup/Dockerfile
        
            `RUN bench get-app <app_name> <app_repo_url>`

* Config production_setup/conf/frappe-docker-conf/init.sh to install custom app

    ```
    echo "----------------------- [ create install erpnext ] ---------------------------------"
    bench install-app <app_name>
    ```

* Build docker image

    `docker build .`
  
* Get latest  image id

    `docker images`
  
* Tag image

    `docker tag <image_id> <docker_hub_username>/<docker_hub_repo_name>:<tag>`
    
* [Create docker hub user and repository](https://docs.docker.com/docker-hub/repos/#creating-a-new-repository-on-docker-hub)

* Push image to docker hub

    `docker push <docker_hub_username>/<docker_hub_repo_name>:<tag>`
    