There are 3 way to use [erpnext-docker-debian](https://hub.docker.com/r/pipech/erpnext-docker-debian/) image.

1. [Trial setup](/erpnext-docker-debian/trial_setup)
This setup is the most easy and straightforward way to run ERPNext on Docker,
it will run pre-build docker image from Docker hub.

2. [Development setup](/erpnext-docker-debian/development_setup)
This setup will share apps and sites folder to host machine
so you could explore the code.

3. [Production setup](/erpnext-docker-debian/production_setup)
In this setup we use the same ERPNext image as we use in trial setup
and config it to run production
and instead of running all service in single container we separate some and put it into 8 container,
and most important thing is it separate data volumes from container to docker volumes.
