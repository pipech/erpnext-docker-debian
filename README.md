#  ERPNext on Docker

**The goal of this repo is stability.**

##### Problem

* ERPNext development tend to go very fast, new update comes every days 
and some will be bugs.

* ERPNext use many dependencies, during installation sometimes somethings might went wrong.

##### Solution

Using docker we can pre-build images and push it to [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/),
so you will always have usable images and can choose which version you want to use.

## Usage

Read at [https://pipech.github.io/erpnext-docker-debian](https://pipech.github.io/erpnext-docker-debian)


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

## Contributing

Pull requests for new features, bug fixes, and suggestions are welcome!

## License

MIT