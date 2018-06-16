---
layout: page
title: Development Setup
permalink: /development_setup/
userpass: user_pass.md
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

* Start development server

    `bench start`

* Go to web browser and access ERPNext

    `http://localhost:8000`

* Access mysql using [MySQL Workbench](https://www.mysql.com/products/workbench)

### User & Password

{% include {{ page.userpass }} %}

### Clean-up

* Stop development server, press ctrl +c in terminal

    `ctrl + c`

* Exit from container

    `exit`

* Remove container using docker-compose

    `docker-compose down`

### Create new site

* Change user and db host from 172.x.x.x to %, it'll make frappe able to connect to mariadb when frappe change ip

    `mysql -h mariadb -uroot -pmysql < "./init.sql"`

### Custom-app

Has to run this way because of in development setup Apps and Sites folder 
own by root user when we run `bench get-app https://pipech@bitbucket.org/pipech/erpnext-thai-localize.git`
we will get `OSError: [Errno 13] Permission denied` error. This is a work around method.

    bench new-app erpnext_shopify
    cd apps && rm -rf erpnext_shopify
    git clone https://github.com/frappe/erpnext_shopify
    cd ..
    bench install-app erpnext_shopify
    bench update --build

### Using git control for frappe & eprnext

I don't know why but somehow installation process mess up version control of frappe & erpnext.

    cd apps
    rm -rf erpnext
    git clone https://github.com/frappe/erpnext.git --branch master --depth 1 --origin upstream
    rm -rf frappe
    git clone https://github.com/frappe/frappe.git --branch master --depth 1 --origin upstream
    cd ..
    bench update --patch
    bench update --build
