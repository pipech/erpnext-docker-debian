#!/bin/sh
set -e

echo "-> Set ownership of sites folder"
chown frappe:frappe /home/frappe/bench/sites

echo "-> Clearing cache"
su frappe -c "bench execute frappe.cache_manager.clear_global_cache"

echo "-> Linking assets"
su frappe -c "ln -sf /home/frappe/bench/built_sites/assets /home/frappe/bench/sites/assets"
su frappe -c "ln -sf /home/frappe/bench/built_sites/apps.json /home/frappe/bench/sites/apps.json"
su frappe -c "ln -sf /home/frappe/bench/built_sites/apps.txt /home/frappe/bench/sites/apps.txt"

exec "$@"
