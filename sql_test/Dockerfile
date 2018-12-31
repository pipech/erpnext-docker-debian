FROM debian:jessie

RUN echo 'mysql-server mysql-server/root_password password password' | debconf-set-selections \
    && echo 'mysql-server mysql-server/root_password_again password password' | debconf-set-selections \
    && apt-get update \
    && apt-get -y install mysql-server
