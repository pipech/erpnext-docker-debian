#!/bin/bash

# turn on debug mode > https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

# env has been set from dockerfile
benchWD=/home/$systemUser

# change working directory
cd $benchWD/production_config

# set bench config
sudo cp common_site_config_docker.json $benchWD/$benchFolderName/sites/common_site_config.json

# set supervisor config
sudo cp supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# set nginx config
sudo -E /bin/bash -c "envsubst '\$NGINX_SERVER_NAME' < nginx.temp > /etc/nginx/conf.d/default.conf"

# start nginx
sudo nginx

# start supervisor
sudo /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisor.conf
