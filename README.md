#  ERPNext on Docker

**The goal of this repo is stability.**

##### Problem

* ERPNext development tend to go very fast, new update comes every days 
and some will be bugs.

* ERPNext use many dependencies, during installation sometimes somethings might went wrong.

##### Solution

Using docker we can pre-build images and push it to [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/),
so you will always have usable images and can choose which version you want to use.

## How to use

In any command if there are `<something>` that means it just a name or container id
you should change it to suit your environment.

Example :

Change this >
`docker run -it -p 8000:8000 -p 9000:9000 --name <container_name> pipech/erpnext-docker-debian:stable bash`

To this > `docker run -it -p 8000:8000 -p 9000:9000 --name anything pipech/erpnext-docker-debian:stable bash`

### Prerequisite

* [Docker](https://docs.docker.com/get-started/#conclusion-of-part-one)

### Images Tags

* Tag : `latest` > latest image build

* Tag : `stable` > we can login and access ERPNext desk

* Tag : `v10.0.20` > the higher version of ERPNext or Frappe

## Trial  Setup

This setup is the most easy and straightforward way to run ERPNext on Docker, 
it will run pre-build docker image from Docker hub. 

### Usage

* Run latest erpnext_debian image from pipech Docker hub

    `docker run -it -p 8000:8000 -p 9000:9000 --name <container_name> pipech/erpnext-docker-debian:stable bash`

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
    
* Remove container

    `docker rm -f <container_name>`
    
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

    `docker exec -it <frappe_container_id> bash`
    
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

    `docker stack deploy -c prd.yml <stack_name>`

* Find frappe container id

    `docker ps -a`

* Find frappe container id

    `docker exec -it <frappe_container_id> bash`
    
* Run init.sh

    `cd .. && . init.sh`
    
* Exit from container

    `exit`
    
* Restart supervisor

    `docker exec -d <frappe_container_id> sudo service supervisor stop`
    
    `docker exec -d <frappe_container_id> sudo service supervisor start`

* Config mysql

    `docker exec -it <mysql_container_id> bash`

    `mysql -u "root" "-p123" < "/home/init.sql"`

* Go to web browser and access ERPNext

    `http://localhost`

## Contributing

Pull requests for new features, bug fixes, and suggestions are welcome!

## License

MIT