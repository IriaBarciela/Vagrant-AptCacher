#!/bin/sh

if ! ip a | grep 192.168 > /dev/null; then
	ip a add 192.168.1.67/24 dev eth1 && ip l set dev eth1 up
fi
