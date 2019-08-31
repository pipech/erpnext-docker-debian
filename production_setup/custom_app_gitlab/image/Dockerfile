FROM pipech/erpnext-docker-debian:v11-py3-latest

### set workdir
# These variable has been set from base image
# $systemUser, $benchFolderName
USER $systemUser
WORKDIR /home/$systemUser/$benchFolderName

# Copy rsa for github
COPY --chown=$systemUser id_rsa /home/$systemUser/.ssh/id_rsa

### set rsa key
# remove unused key created by ansible
RUN rm /home/$systemUser/.ssh/id_rsa.pub \
    # change id_rsa permission
    && chmod 400 /home/$systemUser/.ssh/id_rsa \
    # add github to known host
    && ssh-keyscan -H github.com >> ~/.ssh/known_hosts \ 
    ### get app
    && bench get-app custom_app git@github.com:github_username/custom_app.git
