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

## Contributing

Pull requests for new features, bug fixes, and suggestions are welcome!

## License

MIT

## Know-Bug

### v10.1.37

* /home/frappe/bench/env/local/lib/python2.7/site-packages/requests/__init__.py:80: 

  RequestsDependencyWarning: urllib3 (1.23) or chardet (3.0.4) doesn't match a supported version!

* bench new-app [app_name]

  bench.utils.CommandFailedError: ./env/bin/pip install -q  -e ./apps/[app_name] --no-cache-dir

### v10.1.35

* bench new-app [app_name]

  bench.utils.CommandFailedError: ./env/bin/pip install -q  -e ./apps/[app_name] --no-cache-dir

### v10.1.30

* bench new-app [app_name]

  bench.utils.CommandFailedError: ./env/bin/pip install -q  -e ./apps/[app_name] --no-cache-dir

### v10.1.23

* none