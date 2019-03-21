#!/bin/bash

# turn on debug mode > https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

# change folder owner
sudo chown frappe:frappe apps

# set mysql config
bench set-mariadb-host mariadb

# set mysql default pass
bench config set-common-config -c root_password "mysql"
bench config set-common-config -c admin_password "admin"

# install apps
cd apps
git clone https://github.com/frappe/frappe.git --branch master --depth 1 --origin upstream
git clone https://github.com/frappe/erpnext.git --branch master --depth 1 --origin upstream
cd ..
bench update --requirements
python -m compileall apps

# remove old site
rm -rf ./sites/site1.local

# create new site
bench new-site dev32.loc
bench use dev32.loc
bench install-app erpnext
bench set-config developer_mode 1

# set mysql host config
mysql -h mariadb -uroot -pmysql < "./init.sql"

# patch sites data
bench clear-cache
bench update --build
bench update --patch --no-backup

set +euxo pipefail
