FROM pipech/erpnext-docker-debian:stable

# set workdir
USER $systemUser
WORKDIR /home/$systemUser/$benchFolderName

# copy config
COPY conf/frappe-docker-conf/common_site_config_docker.json ./sites/common_site_config.json

# move site folder to site-ori folder
# we need to do this because when we first start sites and logs will be blank then we will populate data from
# sites-ori and logs-ori
RUN mkdir sites-ori \
    && mv ./sites/* ./sites-ori/

RUN mkdir logs-ori \
    && mv ./logs/* ./logs-ori/

# install
RUN sudo apt-get -y update \
    && sudo apt-get -y install \
    nginx \
    gettext-base

# copy conf
COPY conf/frappe-docker-conf/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
COPY conf/frappe-docker-conf/nginx.temp /etc/nginx/conf.d/nginx.temp

COPY conf/frappe-docker-conf/start.sh /home/frappe/start.sh
COPY conf/frappe-docker-conf/init.sh /home/frappe/init.sh

# expose port for nginx
EXPOSE 80

# run start.sh when container start
ENTRYPOINT ["/home/frappe/start.sh"]