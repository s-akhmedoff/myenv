# GUIDE
## Installing process after booting in
`` 1. loadkeys i386/qwerty/us.map.gz``

`` 2. timedatectl set-ntp true ``

`` 3. gdisk /dev/sda ``

`` 4. cfdisk /dev/sda``

| Part      |            |         |
| --------- | ---------- | ------- |
| /dev/sda1 | EFI        | 350 MB  |
| /dev/sda2 | SWAP       | $RAM GB |
| /dev/sda3 | Linux Root | ~GB     |
| /dev/sda4 | Linux Home | ~GB     |

`` 5. mkfs.fat -F32 /dev/sda1 && mkswap /dev/sda2 && mkfs.ext4 /dev/sda3 && mkfs.ext4 /dev/sda4`` 

`` 6. mount /dev/sda3 /mnt && mount /dev/sda4 /mnt/home && swapon /dev/sda2``

`` 7. reflector --latest 10 --save /ect/pacman.d/mirrorlist``

`` 8. pacstrap /mnt base base-devel linux-firmware linux-zen linux-zen-docs linux-zen-headers e2fsprogs dosfstools dhcpcd vim man-db man-pages tldr reflector zsh grub os-prober mtools efibootmgr curl git``

`` 9. genfstab -U -p /mnt >> /mnt/etc/fstab ``

`` 10. arch-chroot /mnt``

`` 11. ln -sf /usr/share/zoneinfo/Asia/Tashkent /etc/localtime``

`` 12. hwclock --systohc``

`` 13. vim /etc/locale.gen P.S uncomment en_US.UTF-8``

`` 14. locale-gen``

`` 15. echo "host-arch" > /etc/hostname``

`` 16. echo LANG=en_US.UTF-8 > /etc/locale.conf``

`` 17. export LANG=en_US.UTF-8``

`` 18. vim /etc/hosts``

```shell
$ vim /etc/hosts
127.0.0.1	localhost
::1		localhost
```

`` 19. passwd``

`` 20. vim /etc/sudoers P.S uncomment %wheel``

`` 21. useradd -m -G wheel -s /bin/zsh sada && passwd sada``

`` 22. mkdir /boot/efi && mount /dev/sda1 /boot/efi``

`` 23. grub-install --target=x86_64-efi --bootloader-id=grub-uefi --recheck``

`` 24. grub-mkconfig -o /boot/grub/grub.cfg ``

`` 25. exit && umount -a && reboot`` 

## reboot system, log in, check internet connection, set up git configs, git clone by https and run ./install.sh

1. sudo systemctl enable dhcpcd --now
2. git config --global user.name "user@..."
3. git config --global user.email "user.email@example.com"
4. git clone https://github.com/s-akhmedoff/myenv.git