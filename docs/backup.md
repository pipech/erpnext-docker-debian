---
layout: page
title: Backup docker volume
permalink: /backup/
---

**[frank](https://github.com/pipech/erpnext-docker-debian/blob/master/frank)**

    . frank <backup|restore|delete> <options>

**[Setup CRON Job](https://awc.com.my/uploadnew/5ffbd639c5e6eccea359cb1453a02bed_Setting%20Up%20Cron%20Job%20Using%20crontab.pdf)**

* Make backup.sh

    ```
    . /home/<username>/erpnext-docker-debian/frank backup
    . /home/<username>/erpnext-docker-debian/frank delete
    ```

    copy backup command above and place it in backup.sh

* Move backup.sh to /etc/cron.daily

    `sudo mv backup.sh /etc/cron.daily/backup.sh`

* Change backup.sh permission

    `sudo chmod 755 /etc/cron.daily/backup.sh`

* Add new cron job to crontab, this will open vi editor

    `crontab -e`

* Add this (It'll run backup.sh everyday at 02.00) to vi editor then hit ESC key then type :w followed by :q

    `0 2 * * * /etc/cron.daily/backup.sh`

* Check existing cron job

    `crontab -l`
