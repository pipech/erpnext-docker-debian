#!/bin/bash

set -euxo pipefail

sudo service mysql start
bench start
