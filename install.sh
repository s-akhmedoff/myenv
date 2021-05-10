#!/bin/sh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Custom plugins for oh-my-zsh
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#Latest mirrors
sudo reflector --latest 10 --save /etc/pacman.d/mirrorlist

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Get back
cd ..

# Install packages
yay -S - < pkgs.list

# Make docker runable without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Set up go path
mkdir -p $HOME/go $HOME/go/bin $HOME/go/pkg $HOME/go/src

# Copy all rc
rm -f $HOME/.vimrc $HOME/.zshrc && cp -f .vimrc .zshrc $HOME
