## How to use

There are 3 way to use [erpnext-docker-debian](https://hub.docker.com/r/pipech/erpnext-docker-debian/) image.

1. [Trial setup](trial_setup.md)
This setup is the most easy and straightforward way to run ERPNext on Docker, 
it will run pre-build docker image from Docker hub. 

2. [Development setup](development_setup.md)
This setup will share apps and sites folder to host machine 
so you could explore the code.

3. [Production setup](production_setup.md)
In this setup we use the same ERPNext image as we use in trial setup 
and config it to run production
and instead of running all service in single container we separate some and put it into 8 container,
and most important thing is it separate data volumes from container to docker volumes.

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