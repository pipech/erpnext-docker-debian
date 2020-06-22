FROM debian:10.2

###############################################
# ARG
###############################################
ARG adminPass=12345
ARG mysqlPass=12345
ARG pythonVersion=python3
ARG appBranch=version-12

###############################################
# ENV 
###############################################
# user pass
ENV systemUser=frappe
# locales
ENV LANGUAGE=en_US \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
# prerequisite version
ENV mariadbVersion=10.3 \
    ## nodejs version 12 will causing error 
    ## https://discuss.erpnext.com/t/error-bench-setup-requirements-yarn-install-macos-mojave
    ## Node.js 11.x is no longer actively supported!
    ## You will not receive security or critical stability updates for this version.
    nodejsVersion=10.x
# frappe
ENV benchPath=bench-repo \
    benchFolderName=bench \
    benchRepo="https://github.com/frappe/bench" \
    benchBranch=master \
    frappeRepo="https://github.com/frappe/frappe" \
    erpnextRepo="https://github.com/frappe/erpnext" \
    siteName=site1.local

###############################################
# INSTALL PREREQUISITE
###############################################
RUN apt-get -y update \
    ###############################################
    # config
    ###############################################
    && apt-get -y -q install \
    # locale
    locales locales-all \
    # [fix] "debconf: delaying package configuration, since apt-utils is not installed"
    apt-utils \
    # [fix] "debconf: unable to initialize frontend: Dialog"
    # https://github.com/moby/moby/issues/27988
    && echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections \
    ###############################################
    # install
    ###############################################
    # basic tools
    && apt-get -y -q install \
    wget \
    curl \
    cron \
    sudo \
    git \
    nano \
    openssl \
    ###############################################
    # python 3
    ###############################################
    && apt-get -y -q install \
    build-essential \
    python3-dev \
    python3-setuptools \
    python3-pip \
    ###############################################
    # [playbook] common
    ###############################################
    # debian_family.yml
    && apt-get -y -q install \
    dnsmasq \
    fontconfig \
    htop \
    libcrypto++-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    libxext6 \
    libxrender1 \
    libxslt1-dev \
    libxslt1.1 \
    libffi-dev \
    ntp \
    postfix \
    python3-dev \
    python-tk \
    screen \
    xfonts-75dpi \
    xfonts-base \
    zlib1g-dev \
    apt-transport-https \
    libsasl2-dev \
    libldap2-dev \
    libcups2-dev \
    pv \
    # debian.yml
    ## pillow prerequisites for Debian >= 10
    && apt-get -y -q install \
    libjpeg62-turbo-dev \
    libtiff5-dev \
    tcl8.6-dev \
    tk8.6-dev \
    ## pdf prerequisites debian
    && apt-get -y -q install \
    libssl-dev \
    ## Setup OpenSSL dependancy
    && pip3 install --upgrade pyOpenSSL==16.2.0 \
    ###############################################
    # [playbook] mariadb
    ###############################################
    # add repo from mariadb mirrors
    # https://downloads.mariadb.org/mariadb/repositories
    && apt-get install -y -q software-properties-common dirmngr \
    && apt-key adv --fetch-keys "https://mariadb.org/mariadb_release_signing_key.asc" \
    && add-apt-repository "deb [arch=amd64] http://nyc2.mirrors.digitalocean.com/mariadb/repo/${mariadbVersion}/debian buster main" \
    # mariadb.yml
    && apt-get update \
    && apt-get install -y -q \
    mariadb-server \
    mariadb-client \
    mariadb-common \
    libmariadbclient18 \
    python3-mysqldb \
    ###############################################
    # psutil
    ###############################################
    && pip3 install --upgrade psutil \
    ###############################################
    # [playbook] wkhtmltopdf
    ###############################################
    # https://github.com/frappe/frappe_docker/blob/master/Dockerfile
    # https://gitlab.com/castlecraft/erpnext_kubernetes/blob/master/erpnext-python/Dockerfile
    && apt-get install -y -q \
    wkhtmltopdf \
    libssl-dev \
    fonts-cantarell \
    xfonts-75dpi \
    xfonts-base \
    && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb \
    && dpkg -i wkhtmltox_0.12.5-1.buster_amd64.deb \
    && rm wkhtmltox_0.12.5-1.buster_amd64.deb \
    ###############################################
    # redis
    ###############################################
    && apt-get install -y -q \
    redis-server \
    ###############################################
    # [production] supervisor
    ###############################################
    && apt-get install -y -q \
    supervisor \
    ###############################################
    # [production] nginx
    ###############################################
    && apt-get install -y -q \
    nginx \
    ###############################################
    # nodejs
    ###############################################
    # https://github.com/nodesource/distributions
    && curl --silent --location https://deb.nodesource.com/setup_${nodejsVersion} | bash - \
    && apt-get install -y -q nodejs \
    && sudo npm install -g -y yarn \
    ###############################################
    # docker production setup
    ###############################################
    && apt-get install -y -q \
    # used for envsubst, making nginx cnf from template
    gettext-base \
    ###############################################
    # add sudoers
    ###############################################
    && adduser --disabled-password --gecos "" $systemUser \
    && usermod -aG sudo $systemUser \
    && echo "%sudo  ALL=(ALL)  NOPASSWD: ALL" > /etc/sudoers.d/sudoers \
    ###############################################
    # clean-up
    ###############################################
    && apt-get autoremove --purge -y \
    && apt-get clean -y

###############################################
# SET USER AND WORKDIR
###############################################
USER $systemUser
WORKDIR /home/$systemUser

###############################################
# COPY
###############################################
# mariadb config
COPY ./mariadb.cnf /etc/mysql/mariadb.cnf

###############################################
# INSTALL FRAPPE
###############################################
RUN sudo service mysql start \
    && mysql --user="root" --execute="ALTER USER 'root'@'localhost' IDENTIFIED BY '${mysqlPass}';" \
    ###############################################
    # install bench
    ###############################################
    # clone & install
    && git clone --branch $benchBranch --depth 1 --origin upstream $benchRepo $benchPath \
    && sudo pip3 install -e $benchPath \
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
    && bench --site $siteName install-app erpnext

###############################################
# COPY
###############################################
# production config
COPY production_setup/conf/frappe-docker-conf /home/$systemUser/production_config
# image entrypoint
COPY entrypoint.sh /usr/local/bin/

###############################################
# WORKDIR
###############################################
WORKDIR /home/$systemUser/$benchFolderName

###############################################
# FINALIZED
###############################################
# set entrypoint permission
## prevent: docker Error response from daemon OCI runtime create failed starting container process caused "permission denied" unknown
RUN sudo chmod +x /home/$systemUser/production_config/entrypoint_prd.sh \
    && sudo chmod +x /usr/local/bin/entrypoint.sh

# image entrypoint script
CMD ["/usr/local/bin/entrypoint.sh"]

# expose port
EXPOSE 8000 9000 3306
