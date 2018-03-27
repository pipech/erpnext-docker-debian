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

There are 3 way to use [erpnext-docker-debian](https://hub.docker.com/r/pipech/erpnext-docker-debian/) image.

1. Trial setup

2. Development setup

3. Production setup

In any command if there are `<something>` that means it just a name or container id
you should change it to suit your environment.

Example :

Change this >
`docker run -it -p 8000:8000 -p 9000:9000 --name <container_name> pipech/erpnext-docker-debian:stable bash`

To this > `docker run -it -p 8000:8000 -p 9000:9000 --name anything pipech/erpnext-docker-debian:stable bash`

### Prerequisite

* [Docker](https://docs.docker.com/get-started/#conclusion-of-part-one)

* [Git](https://git-scm.com/download/linux)

### Images Tags

* Tag : `latest` > latest image build

* Tag : `stable` > we can login and access ERPNext desk

* Tag : `v10.0.20` > the higher version of ERPNext or Frappe

## Trial  Setup

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
    
## Development Setup

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

### Prerequisite using Amazon EC2

**Launch new instance**

    
    AMI: Amazon Linux AMI 2017.09.1 (HVM), SSD Volume Type
    Type: t2.small (2GB of Ram)
    
**Update Security Group**

* Update Inbound Rules

    `Add rules > HTTP`

**Connect to instance using ssh**

* Update instance

    `sudo yum update -y`

* Install Docker and Git

    `sudo yum install -y docker git`
    
* Start Docker

    `sudo service docker start`
    
* Add permissions for ec2-user to use Docker

    `sudo usermod -a -G docker ec2-user`
    
* Log out and log back in again to pick up the new docker group permissions. 
    
    You can accomplish this by closing your current SSH terminal window and reconnecting to your instance in a new one.

* Check ec2-user permission

    `docker info`

### Usage

* Pull image

    `docker pull pipech/erpnext-docker-debian-production:stable`

* Init swarm

    `docker swarm init`
    
* Clone repository

    `git clone https://github.com/pipech/erpnext-docker-debian.git`
    
* Change work directory

    `cd erpnext-docker-debian/production_setup`

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
    
* Config mysql

    `docker exec -it <mysql_container_id> bash`

    `mysql -u "root" "-p123" < "/home/init.sql"`

* Exit from container

    `exit`

* Restart frappe continaer

    `docker service update --force <stack_name>_frappe`

* Go to web browser and access ERPNext

    `http://localhost`

### Health-check

* All 6 container should running, some might exit but there have to be 6 container running

    `docker ps -a`
    ```
    CONTAINER ID        IMAGE                                            COMMAND                  CREATED             STATUS                     PORTS                               NAMES
    9e56c741a6a6        pipech/erpnext-docker-debian-production:stable   "sudo /usr/bin/sup..."   4 minutes ago       Up 4 minutes               3306-3307/tcp, 8000/tcp, 9000/tcp   erpnext_frappe.1.vrh0qzzkh6hmou2gk0gqxkpd0
    384d2793df39        nginx:1.12.2                                     "nginx -g 'daemon ..."   7 minutes ago       Up 7 minutes               80/tcp                              erpnext_nginx.1.0fe57owsq5mdgdbkbi33doamk
    391840076d9f        nginx:1.12.2                                     "nginx -g 'daemon ..."   7 minutes ago       Exited (1) 7 minutes ago                                       erpnext_nginx.1.q1yu20jar4jmddzecikdt82sv
    b8ea6922ce3b        nginx:1.12.2                                     "nginx -g 'daemon ..."   7 minutes ago       Exited (1) 7 minutes ago                                       erpnext_nginx.1.riw1gd8vmqmcezkepqrdq35bi
    e2528e1b7bae        pipech/erpnext-docker-debian-production:stable   "sudo /usr/bin/sup..."   7 minutes ago       Exited (0) 4 minutes ago                                       erpnext_frappe.1.pl64cb3nqymyoopzew02gjdu9
    5ec8a5aee49d        redis:alpine                                     "docker-entrypoint..."   7 minutes ago       Up 7 minutes               6379/tcp                            erpnext_redis-queue.1.n0ghgn710k6v9wnrqsuupojqn
    8c45f2b831ee        redis:alpine                                     "docker-entrypoint..."   7 minutes ago       Up 7 minutes               6379/tcp                            erpnext_redis-socketio.1.c1s0mn5x0uiwwv19hcgud8ipu
    a9ece252518d        nginx:1.12.2                                     "nginx -g 'daemon ..."   7 minutes ago       Exited (1) 7 minutes ago                                       erpnext_nginx.1.xau7shgy81e5ap4eonlhzi7s1
    aea2d2ffb36b        redis:alpine                                     "docker-entrypoint..."   7 minutes ago       Up 7 minutes               6379/tcp                            erpnext_redis-cache.1.wbiosu2sc4g87v6d4iaiikq8z
    0c594aaf9846        mariadb:10.2.12                                  "docker-entrypoint..."   7 minutes ago       Up 7 minutes               3306/tcp                            erpnext_mariadb.1.aufnny4nt9h0vnm5h083njbqq
    a6e7f6f0acaa        nginx:1.12.2                                     "nginx -g 'daemon ..."   7 minutes ago       Exited (1) 7 minutes ago                                       erpnext_nginx.1.lq158amte714526tys4bkj4ch
    ```

* Check service in frappe container, all 6 services should run with success

    `docker logs <frappe_container_id>`
    
    ```
    2018-02-09 07:10:53,185 CRIT Supervisor running as root (no user in config file)
    2018-02-09 07:10:53,192 INFO supervisord started with pid 5
    2018-02-09 07:10:54,196 INFO spawned: 'bench-frappe-schedule' with pid 8
    2018-02-09 07:10:54,197 INFO spawned: 'bench-frappe-default-worker-0' with pid 9
    2018-02-09 07:10:54,198 INFO spawned: 'bench-frappe-long-worker-0' with pid 10
    2018-02-09 07:10:54,200 INFO spawned: 'bench-frappe-short-worker-0' with pid 11
    2018-02-09 07:10:54,207 INFO spawned: 'bench-node-socketio' with pid 12
    2018-02-09 07:10:54,217 INFO spawned: 'bench-frappe-web' with pid 13
    2018-02-09 07:10:55,232 INFO success: bench-frappe-schedule entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
    2018-02-09 07:10:55,232 INFO success: bench-frappe-default-worker-0 entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
    2018-02-09 07:10:55,232 INFO success: bench-frappe-long-worker-0 entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
    2018-02-09 07:10:55,232 INFO success: bench-frappe-short-worker-0 entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
    2018-02-09 07:10:55,233 INFO success: bench-node-socketio entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
    2018-02-09 07:10:55,233 INFO success: bench-frappe-web entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
    ```

## Contributing

Pull requests for new features, bug fixes, and suggestions are welcome!

## License

MIT