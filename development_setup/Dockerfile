FROM pipech/erpnext-docker-debian:v10.1.23

# set workdir
USER $systemUser
WORKDIR /home/$systemUser/$benchFolderName

# move sites and apps sites
RUN mkdir sites-dev \
    && mv ./sites/* ./sites-dev/

RUN mkdir apps-dev \
    && mv ./apps/* ./apps-dev/

COPY ./frappe-docker-conf /home/$systemUser/$benchFolderName

# run start mysql service when container start
CMD ["sudo", "mysqld"]