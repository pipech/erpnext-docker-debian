#!/bin/sh
set -e

echo "-> Bench build"
ln -s /home/$systemUser/$benchFolderName/build_assets /home/$systemUser/$benchFolderName/sites/assets

echo "-> Bursting env into config"
envsubst '$DOMAIN_PANICH_ADMIN' < /home/$systemUser/temp_nginx.conf > /etc/nginx/conf.d/default.conf
envsubst '$PATH,$HOME,$NVM_DIR,$NODE_VERSION' < /home/$systemUser/temp_supervisor.conf > /home/$systemUser/supervisor.conf

echo "-> Starting nginx"
nginx

echo "-> Starting supervisor"
/usr/bin/supervisord -c /home/$systemUser/supervisor.conf
