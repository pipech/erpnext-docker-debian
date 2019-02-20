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

* **v10.x.x (v10) - v10 [python2]**
  * v10-py2-latest
* **Master (mas) - v11 [python2, python3]**
  * mas-py2-latest
  * mas-py3-latest
* **Develop (dev) - v12 [python3]**
  * dev-py3-latest

# Usage on AWS EC2

{% include {{ page.ec2 }} %}
