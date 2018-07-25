---
layout: page
title: Setup Amazon EC2
permalink: /setup_ec2/
---

**Launch new instance**

    AMI: Amazon Linux 2 AMI (HVM)
    Type: [Minimum] t2.small (2GB of Ram)
    Storage: [Minimum] 16GB (8GB will bearly)

**Update Security Group**

* Update Inbound Rules

    `Add rules > HTTP, HTTPS, SSH`

**[Install docker and git](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html)**

* Connect to instance using ssh

* Update instance

    `sudo yum update -y`

* Install Docker and Git

    `sudo yum install -y docker git`

* Start Docker

    `sudo service docker start`

* Add permissions for ec2-user to use Docker

    `sudo usermod -a -G docker ec2-user`

* Set auto start Docker after reboot

    `sudo systemctl enable docker`

* Log out and log back in again to pick up the new docker group permissions.

    You can accomplish this by closing your current SSH terminal window and reconnecting to your instance in a new one.

* Check ec2-user permission

    `docker info`

**[Set timezone](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html#configure-amazon-time-service)**

* Connect to instance using ssh

* Find timezone in /usr/share/zoneinfo

    `ls /usr/share/zoneinfo`

    `ls /usr/share/zoneinfo/Asia`

* Update timezone in /etc/sysconfig/clock

    `sudo nano /etc/sysconfig/clock`

* Replace ZONE with your timezone

    `ZONE="Asia/Bangkok"`

* Create symbolic link /etc/localtime and your time zone file

    `sudo ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime`

* Reboot

    `sudo reboot`

* Check setting

    `date`
