#!/bin/sh
set -e

echo "-> Linking assets"
ln -s /home/$systemUser/$benchFolderName/built_sites/assets /home/$systemUser/$benchFolderName/sites/assets
ln -s /home/$systemUser/$benchFolderName/built_sites/apps.json /home/$systemUser/$benchFolderName/sites/apps.json
ln -s /home/$systemUser/$benchFolderName/built_sites/apps.txt /home/$systemUser/$benchFolderName/sites/apps.txt

exec "$@"
