#!/bin/bash

# set nginx config
sudo -E /bin/bash -c "envsubst '\$NGINX_SERVER_NAME' < /etc/nginx/conf.d/nginx.temp > /etc/nginx/conf.d/default.conf"

# start nginx
sudo nginx

# start supervisor
sudo /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisor.conf