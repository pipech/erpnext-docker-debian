FROM pipech/erpnext-docker-debian:stable

# set workdir
USER $systemUser
WORKDIR /home/$systemUser/$benchName

# move sites and apps sites
RUN mkdir sites-dev \
    && mv ./sites/* ./sites-dev/

RUN mkdir apps-dev \
    && mv ./apps/* ./apps-dev/

COPY ./frappe-docker-conf /home/$systemUser/$benchName

# run start mysql service when container start
CMD ["sudo", "mysqld"]