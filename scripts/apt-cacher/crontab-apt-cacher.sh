#!/bin/sh

if ! cat /etc/crontab | grep 'apt-cacher-ng' > /dev/null; then

    echo "33 4 * * * root systemctl restart apt-cacher-ng" >> /etc/crontab

fi