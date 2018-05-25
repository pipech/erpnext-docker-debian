FROM pipech/erpnext-docker-debian:stable

# set workdir
USER $systemUser
WORKDIR /home/$systemUser/$benchFolderName

# copy config
COPY ./conf/frappe-docker-conf/common_site_config_docker.json ./sites/common_site_config.json

# move site folder to site-ori folder
RUN mkdir sites-ori \
    && mv ./sites/* ./sites-ori/

RUN mkdir logs-ori \
    && mv ./logs/* ./logs-ori/

# copy supervisor conf
COPY ./conf/frappe-supervisor-conf/supervisor.conf /etc/supervisor/conf.d/docker_supervisor.conf

RUN sudo apt-get install nginx -y

EXPOSE 80

COPY ./conf/frappe-docker-conf/start.sh /home/frappe/start.sh

# run start.sh when container start
ENTRYPOINT ["/home/frappe/start.sh"]