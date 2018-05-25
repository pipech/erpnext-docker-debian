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
ADD conf/frappe-docker-conf/common_site_config_docker.json ./sites/common_site_config.json

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
ADD conf/frappe-docker-conf/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD conf/frappe-docker-conf/nginx.temp /etc/nginx/conf.d/nginx.temp

ADD conf/frappe-docker-conf/start.sh /home/frappe/start.sh
ADD conf/frappe-docker-conf/init.sh /home/frappe/init.sh

# expose port for nginx
EXPOSE 80

# run start.sh when container start
ENTRYPOINT ["/home/frappe/start.sh"]