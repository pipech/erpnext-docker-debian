FROM pipech/erpnext-docker-debian:mas-py3-latest

COPY ./entrypoint.sh /home/frappe/bench/entrypoint.sh
COPY ./launch.json /home/frappe/bench/apps/.vscode/launch.json
COPY ./set_remote.sql /home/frappe/bench/init.sql

# prevent permission denied
RUN sudo chmod 777 /home/frappe/bench/entrypoint.sh \
    && sudo chown -R frappe:frappe /home/frappe/bench/apps/.vscode \
    # prevent - vscode error when trying to attatch to container
    # >> mkdir: cannot create directory ‘/root’: Permission denied
    # I don't think we need to concern about security in dev container.
    && sudo chmod 777 /root \
    # install python3 pip
    && curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" \
    && sudo python3 get-pip.py \
    # install flake8 for vs code
    && /usr/bin/python3 -m pip install -U flake8 --user \
    # setup debugger with vs code 
    # comment out bench serve line on Procfile
    && sed -i 's/web: bench serve --port 8000/# &/' Procfile \
    # without this js won't update untill server is reload
    && bench set-config developer_mode 1 \
    # set mysql remote user
    && sudo service mysql start \
    && mysql -h localhost "-uroot" "-ptravis" < "/home/frappe/bench/init.sql"

# without this socket.io won't work (don't know why)
ENV DEV_SERVER=1
