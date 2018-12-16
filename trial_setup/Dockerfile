ARG base_image
FROM $base_image

ENV siteName=site1.local \
    adminPass=12345 \
    mysqlPass=sql12345

# set user and workdir
USER $systemUser
WORKDIR /home/$systemUser/$benchFolderName

# [work around] add mariadb apt-key first to skip adding from ansible playbook
# which will cause error > "gpg: cannot open '/dev/tty': No such device or address" error
RUN sudo apt-key adv --no-tty --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8

# install mariadb & init new site
RUN sudo bench install mariadb --mysql_root_password $mysqlPass \
    && sudo service mysql start \
    && bench new-site $siteName \
    --mariadb-root-password $mysqlPass  \
    --admin-password $adminPass \
    && bench --site $siteName install-app erpnext
