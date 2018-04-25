---
layout: page
title: Development Setup
permalink: /development_setup/
---

This setup will share apps and sites folder to host machine
so you could explore the code.

### Usage

* Clone repository

    `git clone https://github.com/pipech/erpnext-docker-debian.git`

* Pull image

    `docker pull pipech/erpnext-docker-debian:stable`

* Change work directory

    `cd erpnext-docker-debian/development_setup`

* Run image using docker-compose (In development folder where docker-compose.yml is)

    `docker-compose up -d`

* Find frappe container id

    `docker ps -a`

* Call bash in frappe container

    `docker exec -it <frappe_container_id> bash`

* Run init.sh

    `. init.sh`

* Restart container

    ```
    exit
    docker stop <frappe_container_id>
    docker start <frappe_container_id>
    ```

* Call bash in frappe container

    `docker exec -it <frappe_container_id> bash`


* Start development server

    `bench start`

* Go to web browser and access ERPNext

    `http://localhost:8000`

* Access mysql using [MySQL Workbench](https://www.mysql.com/products/workbench)

    ```
    Hostname : localhost
    Port : 3306
    User : remote
    Pass : 12345
    ```

### Clean-up

* Stop development server, press ctrl +c in terminal

    `ctrl + c`

* Exit from container

    `exit`

* Remove container using docker-compose

    `docker-compose down`
