#!/bin/sh

#Para evitar la pantalla interactiva
export DEBIAN_FRONTEND=noninteractive

apt update
apt install apt-cacher-ng -y 

