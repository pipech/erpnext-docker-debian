---
layout: page
title: Setup Node Exporter on AWS EC2
permalink: /setup_node_exporter_ec2/
---

**Install go prerequisite**

* Install prerequisite

    `sudo yum install -y glibc-static`

**Install go and dependencies**

* Install go

    `sudo amazon-linux-extras install -y golang1.9`

* Update go to version 1.10.3

    unfortunately we need go version > 1.9.4
    https://github.com/prometheus/node_exporter/issues/880

    ```
    # check where go is
    whereis go

    # remove go
    sudo rm -rf /usr/bin/go

    # get go https://golang.org/dl/
    wget -c https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz

    # extract go
    sudo tar -C /usr/bin -xvzf go1.10.3.linux-amd64.tar.gz

    # set go path
    export PATH=$PATH:/usr/bin/go/bin

    # check go version
    go version

    # add go path to bash profile
    nano .bash_profile
    export PATH=$PATH:/usr/bin/go/bin
    ```

**Install node_exporter**

* install node_exporter

    ```
    go get github.com/prometheus/node_exporter
    cd ${GOPATH-$HOME/go}/src/github.com/prometheus/node_exporter
    make
    ```

* test node_exporter

    `/home/ec2-user/go/src/github.com/prometheus/node_exporter/node_exporter`

* create systemd service file for Node Exporter

    `sudo nano /etc/systemd/system/node_exporter.service`

    ```
    [Unit]
    Description=Node Exporter

    [Service]
    User=ec2-user
    ExecStart=/home/ec2-user/go/src/github.com/prometheus/node_exporter/node_exporter

    [Install]
    WantedBy=multi-user.target
    ```

* run node_exporter by systemctl

    ```
    sudo systemctl daemon-reload
    sudo systemctl start node_exporter
    sudo systemctl enable node_exporter
    ```

* restart server

    `sudo reboot`

* check node_exporter

    ```
    sudo systemctl status node_exporter
    curl localhost:9100/metrics
    ```
