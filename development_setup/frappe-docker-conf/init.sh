#!/bin/bash

# turn on debug mode
set -x

echo "----------------------- [ change sites and apps folder to it's original folder] ---------------------------------"

sudo mv ./sites-dev/* ./sites/
sudo mv ./apps-dev/* ./apps/

sudo chown frappe sites
sudo chown frappe apps

bench update --patch

# turn off debug mode
set +x

echo "-"
echo "-"
echo "-"
echo "----------------------- [ DONE! ] ---------------------------------"


