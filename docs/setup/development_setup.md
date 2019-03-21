---
layout: page
title: Development Setup
permalink: /development_setup/
userpass: dev_user_pass.md
---

This setup will share apps and sites folder to host machine
so you could explore the code.

### Usage

* Clone repository

    `git clone https://github.com/pipech/erpnext-docker-debian.git`

* Pull image

    `docker pull pipech/erpnext-docker-debian:mas-py3-latest`

* Change work directory

    `cd erpnext-docker-debian/development_setup`

* Run image using docker-compose (In development folder where docker-compose.yml is)

    `docker-compose up -d`

* Find frappe container id

    `docker ps -a`

* Call bash in frappe container

    `docker exec -it <frappe_container_id> bash`

* Run init.sh

    `. init.sh`

* Start development server

    `bench start`

* Go to web browser and access ERPNext

    `http://localhost:8000`

* Access mysql using [MySQL Workbench](https://www.mysql.com/products/workbench)

### User & Password

{% include {{ page.userpass }} %}

### Clean-up

* Stop development server, press ctrl +c in terminal

    `ctrl + c`

* Exit from container

    `exit`

* Remove container using docker-compose

    `docker-compose down`

### Create new site

* Change user and db host from 172.x.x.x to %, it'll make frappe able to connect to mariadb when frappe change ip

    `mysql -h mariadb -uroot -pmysql < "./init.sql"`

### Custom-app

Has to run this way because of in development setup Apps and Sites folder 
own by root user when we run `bench get-app https://pipech@bitbucket.org/pipech/erpnext-thai-localize.git`
we will get `OSError: [Errno 13] Permission denied` error. This is a work around method.

    bench new-app erpnext_shopify
    cd apps && rm -rf erpnext_shopify
    git clone https://github.com/frappe/erpnext_shopify
    cd ..
    bench install-app erpnext_shopify
    bench update --build

### Setup SocketIO for development mode

Add sitename to hosts name

ie. `127.0.0.1 site1.loc`

Host name location for

* Windows > C:\Windows\System32\Drivers\etc\hosts
* Linux & Mac > /etc/hosts

Then SocketIO will works if you access web site using sitename `http://site1.loc:8000`

### Setup auto-reload for development environment

adding `reloader_type='stat',` to `run_simple` command in `/apps/frappe/frappe/apps.py`

``` python
def serve(port=8000, profile=False, no_reload=False, no_threading=False, site=None, sites_path='.'):
    global application, _site, _sites_path
    _site = site
    _sites_path = sites_path

    from werkzeug.serving import run_simple

    if profile:
            application = ProfilerMiddleware(application, sort_by=('cumtime', 'calls'))

    if not os.environ.get('NO_STATICS'):
            application = SharedDataMiddleware(application, {
                    '/assets': os.path.join(sites_path, 'assets'),
            })

            application = StaticDataMiddleware(application, {
                    '/files': os.path.abspath(sites_path)
            })

    application.debug = True
    application.config = {
            'SERVER_NAME': 'localhost:8000'
    }

    in_test_env = os.environ.get('CI')
    if in_test_env:
            log = logging.getLogger('werkzeug')
            log.setLevel(logging.ERROR)

    run_simple('0.0.0.0', int(port), application,
            reloader_type='stat',
            use_reloader=False if in_test_env else not no_reload,
            use_debugger=not in_test_env,
            use_evalex=not in_test_env,
            threaded=not no_threading)
```
