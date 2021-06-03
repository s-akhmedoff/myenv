#!/bin/sh

# Make docker runable without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Set up go path
mkdir -p $HOME/go $HOME/go/bin $HOME/go/pkg $HOME/go/src

# Copy all rc
rm -f $HOME/.vimrc && cp -f .vimrc $HOME
