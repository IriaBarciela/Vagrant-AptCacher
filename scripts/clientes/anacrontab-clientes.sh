#!/bin/sh

if ! cat /etc/anacrontab | grep 'actualizar-cliente' > /dev/null; then
    echo "1       10       actualizar-cliente      apt update" >> /etc/anacrontab
fi
