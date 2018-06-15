#!/bin/bash

# turn on debug mode > https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

# change sites and apps folder to it's original folder
sudo mv ./sites-dev/* ./sites/
sudo rm -rf ./sites-dev/
sudo mv ./apps-dev/* ./apps/
sudo rm -rf ./apps-dev/

# change sites and apps folder to it's original folder
sudo chown frappe:frappe sites
sudo chown frappe:frappe apps

# set mysql config
bench set-mariadb-host mariadb

# set default pass
bench config set-common-config -c root_password "mysql"
bench config set-common-config -c admin_password "admin"

# remove old site
rm -rf ./sites/site1.local

# create new site
bench new-site dev1.loc
bench use dev1.loc

# set mysql host config
mysql -h mariadb -uroot -pmysql < "./init.sql"

# create install erpnext
bench install-app erpnext

# patch sites data
bench update --patch

set +euxo pipefail