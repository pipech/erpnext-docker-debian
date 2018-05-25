#!/bin/bash

sudo nginx
sudo /usr/bin/supervisord -c /etc/supervisor/conf.d/docker_supervisor.conf