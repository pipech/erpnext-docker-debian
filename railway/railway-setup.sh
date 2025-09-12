#!/bin/bash
set -e

echo "-> Linking assets"
ln -s /home/$systemUser/$benchFolderName/built_sites/assets /home/$systemUser/$benchFolderName/sites/assets

echo "-> Create new site with ERPNext"
bench new-site ${RFP_DOMAIN_NAME} --admin-password ${RFP_SITE_ADMIN_PASSWORD} --no-mariadb-socket --install-app erpnext
bench use ${RFP_DOMAIN_NAME}
