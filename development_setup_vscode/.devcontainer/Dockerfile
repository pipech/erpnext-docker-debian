FROM pipech/erpnext-docker-debian:mas-py3-latest

COPY --chown=frappe ./entrypoint.sh /home/frappe/bench/entrypoint.sh
COPY --chown=frappe ./vscode /home/frappe/bench/apps/.vscode/
COPY --chown=frappe ./sql /home/frappe/bench/
COPY --chown=frappe ./eslint /home/frappe/bench/apps/
COPY --chown=frappe ./flake8 /home/frappe/bench/apps/

# prevent - vscode error when trying to attatch to container
# >> mkdir: cannot create directory ‘/root’: Permission denied
# I don't think we need to concern about security in dev container.
RUN sudo chmod 777 /root \
    # install python3 pip
    && curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" \
    && sudo python3 get-pip.py \
    # setup debugger with vs code 
    # comment out bench serve line on Procfile
    && sed -i 's/web: bench serve --port 8000/# &/' Procfile \
    # without this js won't update untill server is reload
    && bench set-config developer_mode 1 \
    # set mysql remote user
    && sudo service mysql start \
    && mysql -h localhost "-uroot" "-ptravis" < "/home/frappe/bench/set_remote.sql" \
    # install flake8 for vs code
    && /usr/bin/python3 -m pip install -U flake8 --user \
    # install eslint, using Google JavaScript style guide
    && cd /home/frappe/bench \
    && sudo npm install eslint eslint-config-google

# without this socket.io won't work (don't know why)
ENV DEV_SERVER=1
