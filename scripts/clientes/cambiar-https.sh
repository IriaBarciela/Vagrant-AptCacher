#!/bin/sh

echo "deb http://deb.debian.org/debian bookworm main" > /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian bookworm main" >> /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list
echo "deb-src http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian bookworm-updates main" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian bookworm-updates main" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian bookworm-backports main" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian bookworm-backports main" >> /etc/apt/sources.list
