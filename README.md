# :whale: ERPNext on Docker

[![Build Status](https://app.travis-ci.com/pipech/erpnext-docker-debian.svg?branch=master)](https://app.travis-ci.com/github/pipech/erpnext-docker-debian)

**The goal of this repo is stability and repeatability.**

## Problem

- ERPNext development is fast, there are new updates every day and some contain bugs.

- ERPNext uses many dependencies, during installation things might go wrong sometimes.

## Solution

Using docker we can pre-build an image and push it to [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/),
so you will always have usable images and can choose which version you want to use.

## Setup

Read [the Docs](https://github.com/pipech/erpnext-docker-debian/wiki)

## Image tag

- **Version12 - v12 [python3]**
  - v12-py3-latest
- **Version13 - v13 [python3]**
  - v13-py3-latest
- **Develop - [python3]**
  - dev-py3-latest

After a latest tag is created, the new image will be tested and tagged. (Testing process is now very simple, it only run image and return response code 200 if it passes.)

**You can also pulling image by version such as `12-F10.1_E14.3-py3`**

It's recommend to use specific image version rather than latest tag in production setup.

Image tags are hosted and list on [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/)

Images will be automatically created every Monday at Mid-night UTC.

## Tag version semantic

**`12-F10.1_E14.3-py3`**

- Frappe version 12.10.1
- ERPNext version 12.14.3
- Python3

## Contributing

Pull requests for new features, bug fixes, documentation improvements (and typo fixes) and suggestions are welcome!

## License

MIT
