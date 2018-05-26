#!/bin/bash

# turn on debug mode > https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

# change sites and apps folder to it's original folder
sudo mv ./sites-dev/* ./sites/
sudo mv ./apps-dev/* ./apps/

# change sites and apps folder to it's original folder
sudo chown frappe:frappe sites
sudo chown frappe:frappe apps

# patch sites data
bench update --patch
