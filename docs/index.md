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
`docker run -it -p 8000:8000 -p 9000:9000 --name <container_name> pipech/erpnext-docker-debian:mas-py3-latest bash`

To this > `docker run -it -p 8000:8000 -p 9000:9000 --name anything pipech/erpnext-docker-debian:mas-py3-latest bash`

### Prerequisite

* [Docker](https://docs.docker.com/get-started/#conclusion-of-part-one)

* [Git](https://git-scm.com/download/linux)

### Images Tags

* Tag : `latest` > latest image build

* Tag : `mas-py3-latest` > we can login and access ERPNext desk

* Tag : `v10.0.20` > the higher version of ERPNext or Frappe

# Usage on AWS EC2

{% include {{ page.ec2 }} %}
