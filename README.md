# :whale: ERPNext on Docker

![push-docker](https://github.com/pipech/erpnext-docker-debian/actions/workflows/push-docker.yml/badge.svg)

**This repository prioritizes stability and repeatability, and is not designed as the ideal approach for a production environment.**

## Problem

- ERPNext development progresses rapidly, with new updates released daily. Some of these updates may contain bugs.

- ERPNext depends on numerous external components. During installation, these dependencies can sometimes cause issues, and without a pre-built image, it might be impossible to build or use older versions.

## Solution

By using Docker, we can pre-build images and push them to [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/). This ensures that usable images are always available, and you can select the version that best suits your needs.

## Setup

Read [the Docs](https://github.com/pipech/erpnext-docker-debian/wiki)

## Build Process

For detailed information on the build process, please review the [`Dockerfile`](./Dockerfile) and [`.github/workflows/push-docker.yml`](./.github/workflows.push-docker.yml).

In summary:

- Starts with the `frappe/bench` image as the base.
- Integrates all necessary production dependencies like MariaDB, Redis, etc.
- Sets up new sites and verifies their functionality by checking for a response code of 200.
- Upon successful verification, tags and pushes the images to [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/).

Images will be automatically generated every Sunday at 00:00.

## Tag version semantic

**`15-F1.0_E2.0`** represents:

- Frappe version 15.1.0
- ERPNext version 15.2.0

## Contributing

We welcome pull requests for new features, bug fixes, enhancements to documentation (including typo corrections), and suggestions. Your contributions help improve the project!

## License

This project is licensed under the MIT License.
