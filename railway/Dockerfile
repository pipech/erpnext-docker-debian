# ------------------------------------------
# - Stage: 01 - builder
# ------------------------------------------

# This image is also based on frappe/bench which we use for production
# https://github.com/pipech/erpnext-docker-debian/blob/master/Dockerfile
FROM pipech/erpnext-docker-debian:version-15-latest AS builder

# These variable has been set from base image
# $systemUser, $benchFolderName
USER $systemUser
WORKDIR /home/$systemUser/$benchFolderName

RUN echo "-> Start builder" \
    ### remove unused sites, created by base image
    && rm -rf /home/$systemUser/$benchFolderName/sites/site1.local \
    ### install your custom apps here
    # && bench get-app https://github.com/your-repo/custom_app
    && echo "-> Builder done!"


# ------------------------------------------
# - Stage: 02 - production
# ------------------------------------------

# Image version should also match with stage 01
# (Check pipech/erpnext-docker-debian Dockerfile)
# https://github.com/frappe/frappe_docker/blob/main/images/bench/Dockerfile
FROM frappe/bench:v5.22.9

# this env should match stage 01
# (Check pipech/erpnext-docker-debian Dockerfile)
ENV systemUser=frappe
ENV benchFolderName=bench

# Copied bench folder from build stage
COPY --from=builder --chown=$systemUser /home/$systemUser/$benchFolderName /home/$systemUser/$benchFolderName

# Copy template
COPY /railway/temp_nginx.conf /home/$systemUser/temp_nginx.conf
COPY /railway/temp_supervisor.conf /home/$systemUser/temp_supervisor.conf

USER $systemUser
WORKDIR /home/$systemUser/$benchFolderName

# [fix] "debconf: unable to initialize frontend: Dialog"
# https://github.com/moby/moby/issues/27988
ARG DEBIAN_FRONTEND=noninteractive

RUN echo "-> Install nginx & supervisor" \
    # apt-get update
    && sudo apt-get update \
    && sudo apt-get install -y \
    # nginx for serving files
    nginx \
    # supervisor to run multiple server per container
    supervisor \
    && echo "-> Cleaning installation" \
    && sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/* \
    && echo "-> Remove nginx default site" \
    && sudo rm /etc/nginx/sites-enabled/default \
    && echo "-> Rebuilding bench" \
    && bench build \
    && cp -r /home/$systemUser/$benchFolderName/sites /home/$systemUser/$benchFolderName/built_sites

COPY --chown=$systemUser --chmod=0755 /railway/railway-setup.sh /home/$systemUser/$benchFolderName/railway-setup.sh
COPY --chown=$systemUser --chmod=0755 /railway/railway-entrypoint.sh /usr/local/bin/railway-entrypoint.sh
COPY --chown=$systemUser --chmod=0755 /railway/railway-cmd.sh /usr/local/bin/railway-cmd.sh

ENTRYPOINT ["/usr/local/bin/railway-entrypoint.sh"]
CMD ["/usr/local/bin/railway-cmd.sh"]

EXPOSE 80
