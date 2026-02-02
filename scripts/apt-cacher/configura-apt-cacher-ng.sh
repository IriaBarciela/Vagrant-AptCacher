#!/bin/sh

if ! cat /etc/apt-cacher-ng/acng.conf | grep 'PassThroughPattern: \.\*$' >/dev/null; then
     echo "PassThroughPattern : .*" >> /etc/apt-cacher-ng/acng.conf 
fi

if ! cat /etc/apt-cacher-ng/acng.conf | grep 'VfileUseRangeOps: -1' >/dev/null; then
     echo "VfileUseRangeOps: -1" >> /etc/apt-cacher-ng/acng.conf 
fi

if ! cat /etc/apt-cacher-ng/security.conf| grep 'user' > /dev/null; then
    echo "AdminAuth:user:password" >> /etc/apt-cacher-ng/security.conf
    systemctl restart apt-cacher-ng
fi
