FROM frappe/bench:v5.29.0
# https://github.com/frappe/frappe_docker/blob/bc254c2b4ceb9d01dbdd598ace2053326120d27f/images/bench/Dockerfile
# frappe/bench use debian:bookworm-slim as a base image
# then it install dependencies for bench (python, nodejs)

###############################################
# ARG
###############################################
ARG adminPass=12345
ARG mysqlPass=12345
ARG pythonVersion=python3
ARG appBranch=version-15

###############################################
# ENV 
###############################################
# https://docs.frappe.io/framework/user/en/installation
ENV \
    # [Note] frappe user has been set from frappe/bench image
    systemUser=frappe \
    # Dependencies version
    # https://github.com/frappe/frappe_docker/blob/bc254c2b4ceb9d01dbdd598ace2053326120d27f/overrides/compose.mariadb.yaml#L11
    # https://github.com/frappe/frappe_docker/blob/bc254c2b4ceb9d01dbdd598ace2053326120d27f/docs/02-setup/05-overrides.md?plain=1#L9-L13
    mariadbVersion=11.8 \
    # Frappe Related
    benchPath=bench-repo \
    benchFolderName=bench \
    benchRepo="https://github.com/frappe/bench" \
    # [Note] Some how bench use v5.x as Master and Master didn't get the updates
    # Updated: 2026-01-19, This is still the case, master branch is gone now, use v5.x instead
    # https://github.com/frappe/bench/pull/1270
    benchBranch=v5.x \
    frappeRepo="https://github.com/frappe/frappe" \
    erpnextRepo="https://github.com/frappe/erpnext" \
    siteName=site1.local

###############################################
# Config File
###############################################
# MariaDB config
COPY ./mariadb.cnf /home/$systemUser/mariadb.cnf
# image entrypoint
COPY --chown=1000:1000 ./entrypoint.sh /usr/local/bin/entrypoint.sh

# set entrypoint permission
## prevent: docker Error response from daemon OCI runtime create failed starting container process caused "permission denied" unknown
RUN sudo chmod +x /usr/local/bin/entrypoint.sh

###############################################
# Install Dependencies
###############################################
RUN sudo apt-get update \
    && sudo apt-get install -y -q \
    # [fix] "debconf: delaying package configuration, since apt-utils is not installed"
    apt-utils \
    # [fix] "debconf: unable to initialize frontend: Dialog"
    # https://github.com/moby/moby/issues/27988
    && echo "debconf debconf/frontend select Noninteractive" | sudo debconf-set-selections \
    ###############################################
    # Install dependencies: MariaDB
    ###############################################
    && sudo apt-get install -y -q apt-transport-https curl \
    && sudo mkdir -p /etc/apt/keyrings \
    && sudo curl -o /etc/apt/keyrings/mariadb-keyring.pgp "https://mariadb.org/mariadb_release_signing_key.pgp" \
    && echo "deb [signed-by=/etc/apt/keyrings/mariadb-keyring.pgp] https://mirror.kku.ac.th/mariadb/repo/${mariadbVersion}/debian bookworm main" | sudo tee /etc/apt/sources.list.d/mariadb.list \
    && sudo apt-get update \
    && sudo apt-get install -y -q \
    mariadb-server \
    mariadb-client \
    mariadb-common \
    libmariadb3 \
    python3-mysqldb \
    ###############################################
    # Install dependencies: Redis
    ###############################################
    && sudo apt-get install -y -q \
    redis-server \
    ###############################################
    # Install dependencies: supervisor
    ###############################################
    && sudo apt-get install -y -q \
    supervisor \
    ###############################################
    # Install dependencies: nginx
    ###############################################
    && sudo apt-get install -y -q \
    nginx \
    ###############################################
    # clean-up
    ###############################################
    && sudo apt-get autoremove --purge -y \
    && sudo apt-get clean -y \
    ###############################################
    # Init Bench & Setup Site
    ###############################################
    # copy MariaDB Config
    && sudo cp /home/$systemUser/mariadb.cnf /etc/mysql/mariadb.cnf \
    && sudo service mariadb start \
    && sudo mariadb --user="root" --password="${mysqlPass}" --execute="ALTER USER 'root'@'localhost' IDENTIFIED BY '${mysqlPass}';" \
    ###############################################
    # Init Bench
    ###############################################
    && bench init $benchFolderName --frappe-path $frappeRepo --frappe-branch $appBranch --python $pythonVersion \
    # cd into bench folder
    && cd $benchFolderName \
    # install erpnext
    && bench get-app erpnext $erpnextRepo --branch $appBranch \
    # delete temp file
    && sudo rm -rf /tmp/* \
    # start new site
    && bench new-site $siteName \
    --mariadb-root-password $mysqlPass  \
    --admin-password $adminPass \
    && bench --site $siteName install-app erpnext \
    # use site
    && bench use $siteName \
    # compile all python file
    ## the reason for not using python3 -m compileall -q /home/$systemUser/$benchFolderName/apps
    ## is to ignore frappe/node_modules folder since it will cause syntax error
    && $pythonVersion -m compileall -q /home/$systemUser/$benchFolderName/apps/frappe/frappe \
    && $pythonVersion -m compileall -q /home/$systemUser/$benchFolderName/apps/erpnext/erpnext

###############################################
# WORKDIR
###############################################
WORKDIR /home/$systemUser/$benchFolderName

###############################################
# FINALIZED
###############################################
# image entrypoint script
CMD ["/usr/local/bin/entrypoint.sh"]

# expose port
EXPOSE 8000 9000 3306
