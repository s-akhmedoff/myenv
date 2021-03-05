#!/bin/sh

sudo reflector --latest 15 --save /etc/pacman.d/mirrorlist

sudo pacman -Syu 

sudo pacman -S - < resources/pacman.list

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

rm -f $HOME/.vimrc $HOME/.zshrc $HOME/.xinitrc && cp -f .vimrc .zshrc .xinitrc $HOME
rm -rf $HOME/.cofnig && cp -rf .config $HOME

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd ..
yay -S - < resources/aur.list