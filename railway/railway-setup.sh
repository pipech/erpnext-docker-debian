#!/bin/bash
set -e

echo "-> Create empty common site config"
echo "{}" > /home/$systemUser/$benchFolderName/common_site_config.json

echo "-> Create new site with ERPNext"
bench new-site ${RFP_DOMAIN_NAME} --admin-password ${RFP_SITE_ADMIN_PASSWORD} --no-mariadb-socket --db-root-password ${RFP_DB_ROOT_PASSWORD} --install-app erpnext
bench use ${RFP_DOMAIN_NAME}

echo "-> Enable scheduler"
bench enable-scheduler
