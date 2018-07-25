# install node exporter on aws-ec2

    ```bash
    # fixed for collect2: error: ld returned 1 exit status
    # https://github.com/prometheus/node_exporter/issues/679
    sudo yum install -y glibc-static

    # install go and dependencies
    # unfortunately we need go version > 1.9.4
    # https://github.com/prometheus/node_exporter/issues/880
    sudo amazon-linux-extras install golang1.9
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
    # add go path to bash profile
    nano .bash_profile
    export PATH=$PATH:/usr/bin/go/bin

    # install node_exporter
    go get github.com/prometheus/node_exporter
    cd ${GOPATH-$HOME/go}/src/github.com/prometheus/node_exporter
    make

    # create systemd service file for Node Exporter
    sudo nano /etc/systemd/system/node_exporter.service

    [Unit]
    Description=Node Exporter

    [Service]
    User=ec2-user
    ExecStart=/home/ec2-user/go/src/github.com/prometheus/node_exporter/node_exporter

    [Install]
    WantedBy=multi-user.target

    sudo systemctl daemon-reload
    sudo systemctl start node_exporter
    sudo systemctl enable node_exporter
    ```