---
layout: page
title: Trial Setup
permalink: /trial_setup/
userpass: user_pass.md
---

This setup is the most easy and straightforward way to run ERPNext on Docker,
it will run pre-build docker image from Docker hub.

### Usage

* Pull image

    `docker pull pipech/erpnext-docker-debian:mas-py3-latest`

* Run latest erpnext_debian image from pipech Docker hub

    `docker run -d -p 8000:8000 -p 9000:9000 -p 3306:3306 pipech/erpnext-docker-debian:mas-py3-latest`

* Wait 30sec - 1min

* Go to web browser and access ERPNext

    `http://localhost:8000`

### User & Password

{% include {{ page.userpass }} %}


### Start, Stop Container

* Find frappe container id

    `docker ps -a`
    
* Stop container

    `docker stop <frappe_container_id>`
    
* Start container

    `docker start <frappe_container_id>`

### Clean-up

* Find frappe container id

    `docker ps -a`

* Remove container

    `docker rm -f <frappe_container_id>`
