#  ERPNext on Docker

**The goal of this repo is stability.**

##### Problem

* ERPNext development tend to go very fast, new update comes every days 
and some will be bugs.

* ERPNext use many dependencies, during installation sometimes somethings might went wrong.

##### Solution

Using docker we can pre-build images and push it to Docker hub,
so you will always have usable images and can choose which version you want to use.

## How to use

### Prerequisite

* [Docker](https://docs.docker.com/get-started/#conclusion-of-part-one)

## Trial  Setup

This setup is the most easy and straightforward way to run ERPNext on Docker, 
it will run pre-build docker image from Docker hub. 

### Usage

* Run latest erpnext_debian image from pipech Docker hub

    `docker run -it -p 8000:8000 -p 9000:9000 --name test01 pipech/erpnext_debian:latest bash`

* Start mysql service
    
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
    
* Find frappe container id

    `docker ps -a`
    
* Remove container

    `docker rm -f frappe_container_id`
    
## Development Setup

This setup will pull latest Frappe and ERPNext code 
from frappe repository development branch and it will share apps 
and sites folder to host machine so you could explore the code.
    
### Usage

* Run image using docker-compose (In development folder where docker-compose.yml is)

    `docker-compose up -d`
    
* Find frappe container id

    `docker ps -a`

* Find frappe container id

    `docker exec -it frappe_container_id bash`
    
* Run init.sh

    `cd /home/frappe/frappe-docker-conf && . init.sh`

* Go to web browser and access ERPNext

    `http://localhost:8001`

### Clean-up

* Stop development server, press ctrl +c in terminal

    `ctrl + c`
    
* Exit from container

    `exit`
    
* Remove container using docker-compose

    `docker-compose down`
    
## Production Setup

In this setup we use the same ERPNext image as we use in trail setup 
and config it to run production
and instead of running all service in single container we separate some and put it into 6 container.

1. frappe
2. mariadb
3. nginx
4. redis cache
5. redis queue
6. redis socketio

### Usage

* Init swarm

    `docker swarm init`

* Deploy stack using prd.yml as prd1 stack (In production folder where prd.yml is)

    `docker stack deploy -c prd.yml prd1`

* Find frappe container id

    `docker ps -a`

* Find frappe container id

    `docker exec -it frappe_container_id bash`
    
* Run init.sh

    `cd /home/frappe/frappe-docker-conf && . init.sh`

* Go to web browser and access ERPNext

    `http://localhost`
