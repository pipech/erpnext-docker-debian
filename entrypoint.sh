#!/bin/bash

set -euxo pipefail

# work around for mysql failed to start
# https://github.com/moby/moby/issues/34390
sudo find /var/lib/mysql/mysql -exec touch -c -a {} +

sudo service mysql start
bench start
