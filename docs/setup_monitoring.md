---
layout: page
title: Setting up monitoring tools
permalink: /setup_monitoring/
---

**Setting up monitoring tools**

* Setup prometheus.yml

    setup aws key and secret key on ./production_setup/conf/prometheus-conf/prometheus.yml
    if you're not using aws you colud setup node-exporter using node-exporter docker image

* Setup frontend rules in monitor.yml

    `- "traefik.frontend.rule=Host:graf.example1.com"`

* Start docker stack

    `docker stack deploy -c monitor.yml <stack_name>`

* Login

    Username: admin
    Password: admin