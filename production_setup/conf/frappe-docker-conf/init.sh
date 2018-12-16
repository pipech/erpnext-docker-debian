#!/bin/bash

# turn on debug mode > https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

# env has been set from dockerfile
benchWD=/home/$systemUser/$benchFolderName

# change working directory
cd $benchWD

# change folder owner
sudo chown -R $systemUser:$systemUser sites/*
sudo chown -R $systemUser:$systemUser logs/*

# remove old site
cd sites
rm -rf $siteName
cd ..

# create new site
bench new-site $benchNewSiteName
bench use $benchNewSiteName

# create install erpnext
bench install-app erpnext

# fixed JS error
bench update --build

set +euxo pipefail