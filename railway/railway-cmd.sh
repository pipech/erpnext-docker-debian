#!/bin/sh
set -e

echo "-> Bursting env into config"
sudo envsubst '$RFP_DOMAIN_NAME' < /home/$systemUser/temp_nginx.conf > /etc/nginx/conf.d/default.conf
sudo envsubst '$PATH,$HOME,$NVM_DIR,$NODE_VERSION' < /home/$systemUser/temp_supervisor.conf > /home/$systemUser/supervisor.conf

echo "-> Starting nginx"
sudo nginx

echo "-> Starting supervisor"
sudo /usr/bin/supervisord -c /home/$systemUser/supervisor.conf
