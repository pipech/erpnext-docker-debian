---
layout: page
title: Trial Setup
permalink: /trial_setup/
---

This setup is the most easy and straightforward way to run ERPNext on Docker,
it will run pre-build docker image from Docker hub.

### Usage

* Pull image

    `docker pull pipech/erpnext-docker-debian:stable`

* Run latest erpnext_debian image from pipech Docker hub

    `docker run -it --name <container_name> -p 8000-8005:8000-8005 -p 9000-9005:9000-9005 -p 3306-3307:3306-3307 pipech/erpnext-docker-debian:stable bash`

* Start mysql

    `sudo service mysql start`

* Start development server

    `bench start`

* Go to web browser and access ERPNext

    `http://localhost:8000`

### Clean-up

* Stop development server, press ctrl +c in terminal

    `ctrl + c`

* Exit from container

    `exit`

* Remove container

    `docker rm -f <container_name>`
