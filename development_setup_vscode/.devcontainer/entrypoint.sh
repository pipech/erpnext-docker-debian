#!/bin/bash

set -euxo pipefail

# I don't think we need to concern about security in dev container.
# prevent - vscode error when trying to attatch to container
# >> mkdir: cannot create directory ‘/root’: Permission denied
sudo chmod 777 /root

sudo service mysql start
bench start
