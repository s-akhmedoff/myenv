#!/bin/sh

# Latest mirrors
sudo reflector --latest 15 --protocol http,https --save /etc/pacman.d/mirrorlist

# Update packages list
yay -Syu

# Install packages
yay -S - < pkgs.list
