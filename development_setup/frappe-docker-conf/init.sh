#!/bin/bash

# turn on debug mode
set -x

cd ..

# env has been set from dockerfile and docker-compose file
echo "----------------------- [ change owner of bench-dev folder ] ---------------------------------"
sudo chown frappe bench-dev

echo "----------------------- [ init bench ] ---------------------------------"
bench init bench-dev --ignore-exist
cd  bench-dev

echo "----------------------- [ start mysql ] ---------------------------------"
sudo service mysql start

echo "----------------------- [ new site ] ---------------------------------"
bench new-site $benchDevSiteName --mariadb-root-password $mysqlPass --admin-password $benchNewSiteAdminPass
bench use $benchDevSiteName

echo "----------------------- [ install erpnext ] ---------------------------------"
bench get-app erpnext https://github.com/frappe/erpnext
bench install-app erpnext

# turn off debug mode
set +x

echo "-"
echo "-"
echo "-"
echo "----------------------- [ DONE! ] ---------------------------------"


