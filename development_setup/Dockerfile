FROM pipech/erpnext-docker-debian:stable

# set workdir
USER $systemUser
WORKDIR /home/$systemUser/$benchFolderName

# move sites and apps sites
RUN mkdir sites-dev \
    && mv ./sites/* ./sites-dev/

RUN mkdir apps-dev \
    && mv ./apps/* ./apps-dev/
