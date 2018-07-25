# install node exporter on aws-ec2

    ```bash
    # fixed for collect2: error: ld returned 1 exit status
    # https://github.com/prometheus/node_exporter/issues/679
    sudo yum install glibc-static

    # sudo yum install will install go version 1.9.4 (as 2018/07/25)
    # https://github.com/prometheus/node_exporter/issues/880
    # needed go version > 1.9.4
    # install latest version of go
    git clone https://github.com/udhos/update-golang
    cd update-golang
    sudo ./update-golang.sh

    # if -bash: /usr/bin/go: No such file or directory
    export PATH=$PATH:/usr/local/go/bin

    # install node_exporter
    go get github.com/prometheus/node_exporter
    cd ${GOPATH-$HOME/go}/src/github.com/prometheus/node_exporter
    make

    # create systemd service file for Node Exporter
    ```