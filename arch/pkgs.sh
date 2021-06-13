#!/bin/sh

# Update gpg keys
gpg --refresh-keys --keyserver hkps://keys.openpgp.org

# Latest mirrors
sudo reflector --country 'Russia,Kazakhstan' --protocol 'http,https' --latest 50 --sort rate --save /etc/pacman.d/mirrorlist

# Update packages list
yay -Syu

# Install packages
yay -S - < pkgs.list
