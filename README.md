#  ERPNext on Docker

[![Build Status](https://travis-ci.com/pipech/erpnext-docker-debian.svg?branch=master)](https://travis-ci.com/pipech/erpnext-docker-debian)

**The goal of this repo is stability.** 

##### Problem

* ERPNext development is fast, there are new updates every day and some contain bugs.

* ERPNext uses many dependencies, during installation things might go wrong sometimes.

##### Solution

Using docker we can pre-build an image and push it to [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/),
so you will always have usable images and can choose which version you want to use.

## Image tag

Currently, there are 4 important branches on frappe. 
So now on latest tag we'll have 5 tags, including Python3 variants.

* **Version10 - v10 [python2]**
  * v10-py2-latest
* **Version11 - v11 [python2, python3]**
  * v11-py2-latest
  * v11-py3-latest
* **Version12 - v12 [python3]**
  * v12-py3-latest
* **Develop - [python3]**
  * dev-py3-latest

After a latest tag is created, the new image will be tested and tagged. (Testing process is now very simple, it only run image and return response code 200 if it passes.)

You can also pulling image by version such as `12.0.2-py3`

Image tags are hosted and list on [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/)

Images will be automatically created every Monday at Mid-night UTC.

## Setup

Read [the Docs](https://github.com/pipech/erpnext-docker-debian/wiki)

## Contributing

Pull requests for new features, bug fixes, documentation improvements (and typo fixes) and suggestions are welcome!

## License

MIT
