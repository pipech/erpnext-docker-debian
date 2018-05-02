FROM pipech/erpnext-docker-debian:stable

# set workdir
USER $systemUser
WORKDIR /home/$systemUser/$benchFolderName

########## install custom app > Start ##########

### For private repository > Start ###
#
#### install expect, this will use to run install script
#RUN sudo apt-get install -y expect
#
#### add install script to image
#ADD ./conf/frappe-custom-app/install_custom_app.sh /home/$systemUser/install_custom_app.sh
#
#### set git password
##### this is not the best practice to put password in dockerfile
##### so please be super careful with your code and docker-image
##### PLEASE MAKE SURE YOUR REPOSITORY IN BOTH GITHUB AND DOCKERHUB IS SET TO PRIVATE
#ENV git_password=your_git_password
#
#### run install script
#RUN sudo chmod +x /home/$systemUser/install_custom_app.sh; sync \
#    && /home/$systemUser/install_custom_app.sh $git_password
#
### For private repository > End ###


### For public repository > Start ###
#
#RUN bench get-app erpnext_shopify https://github.com/frappe/erpnext_shopify
#
### For public repository > End ###

########## install custom app > End ##########

# copy config
COPY ./conf/frappe-docker-conf/common_site_config_docker.json ./sites/common_site_config.json

# move site folder to site-ori folder
RUN mkdir sites-ori \
    && mv ./sites/* ./sites-ori/

RUN mkdir logs-ori \
    && mv ./logs/* ./logs-ori/

# copy supervisor conf
COPY ./conf/frappe-supervisor-conf/supervisor.conf /etc/supervisor/conf.d/docker_supervisor.conf

# run start.sh when container start
CMD ["sudo", "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/docker_supervisor.conf"]
