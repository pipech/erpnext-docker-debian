#!/bin/bash

set -euxo pipefail

sudo find /var/lib/mysql/mysql -exec touch -c -a {} +
sudo service mysql start
bench start
