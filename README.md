#  ERPNext on Docker

[![Build Status](https://travis-ci.com/pipech/erpnext-docker-debian.svg?branch=master)](https://travis-ci.com/pipech/erpnext-docker-debian)

**The goal of this repo is stability.** 

##### Problem

* ERPNext development is fast, there are new updates every day and some contain bugs.

* ERPNext uses many dependencies, during installation things might go wrong sometimes.

* Chosing the ERPNext version you want to setup is not straight-forward for beginners.

##### Solution

Using docker we can pre-build an image and push it to [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/),
so you will always have usable images and can choose which version you want to use.

## Image tag

Currently, there are three important branches on frappe. 
So now on latest tag we'll have 4 tags, including Python 3 variants.

* **v10.x.x (v10) - v10 [python2]**
  * v10-py2-latest
* **Master (mas) - v11 [python2, python3]**
  * mas-py2-latest
  * mas-py3-latest
* **Develop (dev) - v12 [python3]**
  * dev-py3-latest

After a latest tag is created, the new image will be tested and tagged. (Testing process is now very simple, it only run image and return response code 200 if it passes.)

ie. `11.0.3-beta.39-py2`

Image tags are hosted and list on [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/)

Images will be automatically created every Monday at Mid-night UTC.

## Setup

Read [the Docs](https://github.com/pipech/erpnext-docker-debian/wiki)

## Contributing

Pull requests for new features, bug fixes, documentation improvements (and typo fixes) and suggestions are welcome!

## License

MIT
