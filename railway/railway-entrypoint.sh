#!/bin/sh
set -e

echo "-> Linking assets"
ln -s /home/frappe/bench/built_sites/assets /home/frappe/bench/sites/assets
ln -s /home/frappe/bench/built_sites/apps.json /home/frappe/bench/sites/apps.json
ln -s /home/frappe/bench/built_sites/apps.txt /home/frappe/bench/sites/apps.txt

exec "$@"
