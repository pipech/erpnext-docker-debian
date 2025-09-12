#!/bin/sh
set -e

echo "-> Set ownership of sites folder"
chown frappe:frappe /home/frappe/bench/sites

echo "-> Linking assets"
ln -sf /home/frappe/bench/built_sites/assets /home/frappe/bench/sites/assets
ln -sf /home/frappe/bench/built_sites/apps.json /home/frappe/bench/sites/apps.json
ln -sf /home/frappe/bench/built_sites/apps.txt /home/frappe/bench/sites/apps.txt

exec "$@"
