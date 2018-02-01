FROM debian:9.3

# install prerequisite
RUN apt-get -y update \
    && apt-get -y install \
    build-essential \
    python-setuptools \
    curl \
    wget \
    nano \
    sudo \
    supervisor

# add users without sudo password
ENV systemUser=frappe

RUN adduser --disabled-password --gecos "" $systemUser \
    && usermod -aG sudo $systemUser \
    && echo "%sudo  ALL=(ALL)  NOPASSWD: ALL" > /etc/sudoers.d/sudoers

# set user and workdir
USER $systemUser
WORKDIR /home/$systemUser

# install bench with easy install script
ENV easyinstallRepo='https://raw.githubusercontent.com/frappe/bench/master/playbooks/install.py' \
    adminPass=12345 \
    mysqlPass=12345 \
    benchSetup=develop \
    benchBranch=master \
    benchName=bench

RUN wget $easyinstallRepo \
    && python install.py \
    --without-site \
    --$benchSetup \
    --mysql-root-password $mysqlPass  \
    --admin-password $adminPass  \
    --bench-name $benchName  \
    --bench-branch $benchBranch

# set workdir
USER $systemUser
WORKDIR /home/$systemUser/$benchName

# create new site & install erpnext & switch to branch master
ENV erpnextRepo='https://github.com/frappe/erpnext' \
    siteName=site1.local \
    branch=master

RUN  sudo service mysql start \
    # create new site
    && bench new-site $siteName \
    --mariadb-root-password $mysqlPass  \
    --admin-password $adminPass \
    # install erpnext
    && bench get-app erpnext $erpnextRepo \
    && bench --site $siteName install-app erpnext \
    # switch to master branch
    && bench switch-to-branch $branch \
    && bench update --patch

# expose port
EXPOSE 8000 9000 3306 3307
