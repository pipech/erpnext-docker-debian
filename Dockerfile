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
    supervisor \
    cron

# work around for  "cmd": "chsh frappe -s $(which bash)", "stderr": "Password: chsh: PAM: Authentication failure"
# caused by > bench/playbooks/create_user.yml > shell: "chsh {{ frappe_user }} -s $(which bash)"
RUN sed -i 's/auth       required   pam_shells.so/auth       sufficient   pam_shells.so/' /etc/pam.d/chsh

# Set locales
RUN apt-get -y update \
    && apt-get -y install locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen

ENV LC_ALL=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LANG=en_US.UTF-8

# add users without sudo password
ENV systemUser=frappe

RUN adduser --disabled-password --gecos "" $systemUser \
    && usermod -aG sudo $systemUser \
    && echo "%sudo  ALL=(ALL)  NOPASSWD: ALL" > /etc/sudoers.d/sudoers

# set user and workdir
USER $systemUser
WORKDIR /home/$systemUser

# install prerequisite for bench with easy install script
ENV easyinstallRepo='https://raw.githubusercontent.com/frappe/bench/master/playbooks/install.py' \
    benchPath=bench-repo \
    benchRepo='https://github.com/frappe/bench' \
    benchBranch=master \
    frappeRepo='https://github.com/frappe/frappe' \
    frappeBranch=master \
    # for python 2 use = python
    # for python 3 use = python3 or python3.6 for centos
    pythonVersion=python \
    benchFolderName=bench \
    erpnextRepo='https://github.com/frappe/erpnext' \
    erpnextBranch=master \
    siteName=site1.local \
    branch=master \
    adminPass=12345 \
    mysqlPass=travis \
    # mysql remote user
    remoteUser=remote \
    remotePass=12345

RUN wget $easyinstallRepo \
    # install bench prerequisite
    && python install.py \
    --without-bench-setup \
    # install bench & init bench folder
    && rm -rf bench \
    && git clone -b $benchBranch $benchRepo $benchPath  \
    && sudo pip install -e $benchPath \
    && bench init $benchFolderName --frappe-path $frappeRepo --frappe-branch $frappeBranch --python $pythonVersion \
    # cd to bench folder and start mysql service
    && cd $benchFolderName \
    && sudo service mysql start \
    # create new site
    && bench new-site $siteName \
    --mariadb-root-password $mysqlPass  \
    --admin-password $adminPass \
    # install erpnext
    && bench get-app erpnext $erpnextRepo --branch $erpnextBranch \
    && bench --site $siteName install-app erpnext \
    # switch to master branch
    && bench switch-to-branch $branch \
    && bench update --patch \
    # add mysql remote user, so we can connect to mysql inside container from host
    && mysql -u "root" "-p$mysqlPass" -e "CREATE USER '$remoteUser'@'%' IDENTIFIED BY '$remotePass';" \
    && mysql -u "root" "-p$mysqlPass" -e "GRANT ALL ON *.* TO '$remoteUser'@'%';"

# change back config for work around for  "cmd": "chsh frappe -s $(which bash)", "stderr": "Password: chsh: PAM: Authentication failure"
RUN sudo sed -i 's/auth       sufficient   pam_shells.so/auth       required   pam_shells.so/' /etc/pam.d/chsh

# work around for worker | Error: no such option: --quiet
# caused by > bench/bench/config/templates/Procfile > worker_short: bench worker --queue short --quiet
RUN sed -i 's/--quiet//' /home/frappe/bench/Procfile

# set user and workdir
USER $systemUser
WORKDIR /home/$systemUser/$benchFolderName

# run start mysql service when container start
CMD ["sudo", "mysqld"]

# expose port
EXPOSE 8000-8005 9000-9005 3306-3307
