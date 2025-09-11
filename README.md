# :whale: ERPNext on Docker 

![push-docker](https://github.com/pipech/erpnext-docker-debian/actions/workflows/push-docker.yml/badge.svg)

**This repository prioritizes stability, repeatability and simplicity, and is not designed as the ideal approach for a production environment.**

## Problem

- ERPNext development progresses rapidly, with new updates released daily. Some of these updates may contain bugs.

- ERPNext depends on numerous external components. During installation, these dependencies can sometimes cause issues, and without a pre-built image, it might be impossible to build or use older versions.

## Solution

By using Docker, we can pre-build images and push them to [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/). This ensures that usable images are always available, and you can select the version that best suits your needs.

## Usage

### Trial Setup

This setup is designed for users who want to explore the system and is not suitable for production use.

```sh
docker pull pipech/erpnext-docker-debian:version-15-latest

docker run -d -p 8000:8000 -p 9000:9000 -p 3306:3306 pipech/erpnext-docker-debian:version-15-latest
```

The site should be available at http://localhost:8000 after 1-2 minutes.

### Development Setup

This is a self-contained development setup. Developers can fully isolate their environment. The setup utilizes Visual Studio Code and its Dev Containers feature.

1. Open Visual Studio Code.
1. Open the Command Palette (View > Command Palette or Ctrl + Shift + P).
1. Type: `Open Folder in Container`.
1. Select the `setup_development` folder.

For every startup, run:

```sh
sudo service mariadb start
bench start
```

### Production Setup

For best practices in a production environment, [Official Frappe Docker](https://github.com/frappe/frappe_docker).

## User & Password

```
ERPNext | U: administrator    P: 12345
MariaDB | U: root             P: 12345
```

## Build Process

For detailed information on the build process, please review the [`Dockerfile`](./Dockerfile) and [`.github/workflows/push-docker.yml`](./.github/workflows/push-docker.yml).

In summary:

- Starts with the `frappe/bench` image as the base.
- Integrates all necessary production dependencies like MariaDB, Redis, etc.
- Sets up new sites and verifies their functionality by checking for a response code of 200.
- Upon successful verification, tags and pushes the images to [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/).

Images will be automatically generated every Sunday at 00:00.

## Tag version semantic

**`15-F45.0_E39.0`** represents:

- Frappe version 15.45.0
- ERPNext version 15.39.0

## Contributing

We welcome pull requests for new features, bug fixes, enhancements to documentation (including typo corrections), and suggestions. Your contributions help improve the project!

## License

This project is licensed under the MIT License.
