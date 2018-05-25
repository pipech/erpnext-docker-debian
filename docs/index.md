---
layout: home
setup: setup.md
ec2: ec2.md
remove_header: remove-header.html
---

{% include {{ page.remove_header }} %}

# How to use

{% include {{ page.setup }} %}

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

# Usage on AWS EC2

{% include {{ page.ec2 }} %}

# Installing custom app

### Trial setup

    bench get-app https://github.com/frappe/erpnext_shopify
    bench install-app erpnext_shopify
    bench update --build

### Development setup

Has to run this way because of in development setup Apps and Sites folder 
own by root user when we run `bench get-app https://pipech@bitbucket.org/pipech/erpnext-thai-localize.git`
we will get `OSError: [Errno 13] Permission denied` error. This is a work around method.

    bench new-app erpnext_shopify
    cd apps && rm -rf erpnext_shopify
    git clone https://github.com/frappe/erpnext_shopify
    cd ..
    bench install-app erpnext_shopify
    bench update --build
    
### Production setup

* [Install custom app](/erpnext-docker-debian/create_custom_app_image)