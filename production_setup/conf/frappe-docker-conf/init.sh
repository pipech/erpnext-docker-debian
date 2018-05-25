#!/bin/bash

# turn on debug mode
set -x

# env has been set from dockerfile
benchWD=/home/$systemUser/$benchFolderName

echo "----------------------- [ move to bench directory ] ---------------------------------"
cd $benchWD

echo "----------------------- [ change folder owner ] ---------------------------------"
sudo chown -R $systemUser:$systemUser sites/*
sudo chown -R $systemUser:$systemUser logs/*

echo "----------------------- [ remove old site ] ---------------------------------"
cd sites
rm -rf $siteName
cd ..

echo "----------------------- [ config bench ] ---------------------------------"
bench set-mariadb-host mariadb

echo "----------------------- [ create new site ] ---------------------------------"
bench new-site $benchNewSiteName
bench use $benchNewSiteName

echo "----------------------- [ create install erpnext ] ---------------------------------"
bench install-app erpnext

echo "----------------------- [ fixed JS error ] ---------------------------------"
bench update --build

# turn off debug mode
set +x

echo "-"
echo "-"
echo "-"
echo "----------------------- [ DONE! ] ---------------------------------"
