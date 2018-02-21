#!/bin/bash

# turn on debug mode
set -x

echo "----------------------- [ change sites and apps folder to it's original folder ] ---------------------------------"

sudo mv ./sites-dev/* ./sites/
sudo mv ./apps-dev/* ./apps/

sudo chown frappe sites
sudo chown frappe apps

bench update --patch

echo "----------------------- [ comment bind-address line in my.cnf ] ---------------------------------"

sudo sed -i '/bind-address/ s/^/#/' /etc/mysql/my.cnf

echo "----------------------- [ create mysql remote user and grant all privilege ] ---------------------------------"

mysql -u "root" "-p123" < "./init.sql"

# turn off debug mode
set +x

echo "-"
echo "-"
echo "-"
echo "----------------------- [ DONE! ] ---------------------------------"


