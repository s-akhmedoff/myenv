#!/bin/sh

#Latest mirrors
sudo reflector --latest 10 --save /etc/pacman.d/mirrorlist

# Upgrade system
sudo pacman -Syu 

# Install default packages
sudo pacman -S - < resources/pacman.list

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Custom plugins for oh-my-zsh
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Configs for vim, zsh and xinitrc
rm -f $HOME/.vimrc $HOME/.zshrc $HOME/.xinitrc && cp -f .vimrc .zshrc .xinitrc $HOME
# Configs for i3, i3status and alacritty
rm -rf $HOME/.config/i3 $HOME/.config/alacritty $HOME/.config/i3status && cp -rf .config $HOME

# Make docker runable without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 

# Set up go path
mkdir -p $HOME/go $HOME/go/bin $HOME/go/pkg $HOME/go/src

# Install yay manually
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install aur packages
cd ..
yay -S - < resources/aur.list

# Packages for laptop (may require to install additional wifi driver):
#sudo pacman -S acpi xorg-xbacklight netctl ifplugd

# Microcode for Intel or AMD based CPU:
#sudo pacman -S intel-ucode (amd-ucode)
#grub-mkconfig -o /boot/grub/grub.cfg

# Free Intel based GPU packages:
#sudo pacman -S xf86-video-intel mesa

# Free and Prop. Nvidia based GPU packages:
#sudo pacman -S xf86-video-nouveau mesa
#sudo pacman -S nvidia-dkms nvidia-utils (prop)

# Optional packages only for self using purpose:
#yay -S - < resources/optional.list

# PERFORM REBOOT AFTER COMPLETE