# GUIDE
## Installing process after booting in
`` 1. loadkeys i386/qwerty/us.map.gz``

`` 2. timedatectl set-ntp true ``

`` 3. gdisk /dev/sda ``

`` 4. cfdisk /dev/sda``

| Part      |            |                       |         |
| --------- | ---------- | --------------------- | ------- |
| /dev/sda1 | EFI        | mkfs.fat -F32         | 350 MB  |
| /dev/sda2 | Linux Root | mkfs.btrfs -f -L root | ~GB     |
| /dev/sda3 | Linux Home | mkfs.btrfs -f -L home | ~GB     |
| /dev/sda4 | SWAP       | mkswap && swapon      | $RAM GB |

`` 5. mkfs.fat -F32 /dev/sda1; \`` 

​	``	mkfs.btrfs -f -L root /dev/sda2; \``

​	`` mkfs.btrfs -f -L home /dev/sda3; \``

​	`` mkswap /dev/sda4 && swapon /dev/sda2 `` 

`` 6. mount /dev/sda2 /mnt && btrfs sub cr /mnt/@ && umount /dev/sda2; \`` 

​	``mount /dev/sda3 /mnt && btrfs sub cr /mnt/@home && umount /dev/sda3 ``

​		`` 6.1 mount -o noatime,commit=120,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/sda2 /mnt ``

​		`` 6.2 mkdir -p /mnt/home ``

​		`` 6.3 mount -o noatime,commit=120,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/sda3 /mnt/home ``

`` 7. reflector --latest 10 --save /ect/pacman.d/mirrorlist``

`` 8. pacstrap /mnt base base-devel linux-firmware linux-zen linux-zen-docs linux-zen-headers e2fsprogs dosfstools dhcpcd vim man-db man-pages tldr reflector fakeroot zsh grub os-prober mtools efibootmgr curl git btrfs-progs networkmanager grub-btrfs network-manager-applet dialog``

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

​	`` 20.1 vim /etc/mkinitcpio.conf``

`` 21. useradd -m -G wheel -s /bin/zsh sada && passwd sada``

`` 22. mkdir /boot/efi && mount /dev/sda1 /boot/efi``

`` 23. grub-install --target=x86_64-efi --bootloader-id=arch --recheck``

`` 24. grub-mkconfig -o /boot/grub/grub.cfg ``

`` 25. exit && umount -a && reboot`` 

## reboot system, log in, check internet connection, set up git configs, git clone by https and run ./install.sh

1. sudo systemctl enable dhcpcd --now
2. sudo systemctl enable networkmanager --now
3. git config --global user.name "user@..."
4. git config --global user.email "user.email@example.com"
5. git clone https://github.com/s-akhmedoff/myenv.git