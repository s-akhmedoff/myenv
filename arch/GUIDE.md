# 													GUIDE
## Installation

* Verify the boot mode

```shell
$ ls /sys/firmware/efi/efivars
```


* Set Net Time

```shell
$ timedatectl set-ntp true
```

* Verify GPT

```shell
$ gdisk /dev/sda
```

4. Make Partitions on disk

```shell
$ cfdisk /dev/sda
```

> Here is default partitions table

| Partitions | Type       | File system | Size   |
| ---------- | ---------- | ----------- | ------ |
| /dev/sda1  | EFI        | fat         | 512 MB |
| /dev/sda2  | Linux Root | btrfs       | 50 %   |
| /dev/sda3  | Linux Home | btrfs       | 50 %   |
| /dev/sda4  | SWAP       | swap        | 8 GB   |

5. Make file systems

```shell
$ mkfs.fat -F32 /dev/sda1 			# EFI
$ mkfs.btrfs -f -L root /dev/sda2	# Linux Root
$ mkfs.btrfs -f -L home /dev/sda3	# Linux Home
$ mkswap /dev/sda4					# Swap
```

6. Mount root and create sub volume

```shell
$ mount /dev/sda2 /mnt && btrfs sub cr /mnt/@ && umount /dev/sda2
```

7. Mount home and create sub volume

```shell
$ mount /dev/sda3 /mnt && btrfs sub cr /mnt/@home && umount /dev/sda3
```

8. Merge Mounts

```shell
$ mount -o noatime,commit=120,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/sda2 /mnt
$ mkdir -p /mnt/home
$ mount -o noatime,commit=120,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/sda3 /mnt/home
$ mkdir -p /mnt/boot/efi
$ mount /dev/sda1 /mnt/boot/efi
```

9. Update Mirror list

```shell
$ reflector --country 'Russia,Kazakhstan' --protocol http --protocol https --sort rate --latest 50 --save /ect/pacman.d/mirrorlist
```

* Add third party repo

Antidote Repo

```shell
$ pacman-key --recv-key B545E9B7CD906FE3 
$ pacman-key --lsign-key B545E9B7CD906FE3
```


``` shell
$ vim /etc/pacman.conf
[andontie-aur]
Server = https://aur.andontie.net/$arch
```

Chaotic Repo

```shell
$ pacman-key --recv-key 3056513887B78AEB
$ pacman-key --lsign-key 3056513887B78AEB
$ pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-'{keyring,mirrorlist}'.pkg.tar.zst' 
```


``` shell
$ vim /etc/pacman.conf
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
```

10. Install in new root

```shell
$ pacman -Syu
$ pacstrap /mnt base base-devel linux-firmware linux-xanmod linux-xanmod-headers e2fsprogs dosfstools dhcpcd vim man-db openssh man-pages tldr reflector fakeroot zsh grub os-prober mtools efibootmgr curl git btrfs-progs networkmanager dialog
```

11. Generate file system table

```shell
$ genfstab -U -p /mnt >> /mnt/etc/fstab
```

12. Change root

```shell
$ arch-chroot /mnt
```

### Inside the chroot

1. Local time

```shell
$ ln -sf /usr/share/zoneinfo/Asia/Tashkent /etc/localtime
```

2. Sync sys clock

```shell
$ hwclock --systohc
```

3. Uncomment en_US.UTF-8

```shell
$ vim /etc/locale.gen
```

4. Generate localization

```shell
$ locale-gen
```

5. Set host name

```shell
$ echo "host-arch" > /etc/hostname
```

6. Set Locale Language

```shell
$ echo LANG=en_US.UTF-8 > /etc/locale.conf
```

7. Set environment language

```shell
$ export LANG=en_US.UTF-8
```

8. Set hosts

```shell
$ vim /etc/hosts
127.0.0.1	localhost
::1		localhost
```

9. Set root password

```shell
$ passwd
```

10. Uncomment wheel group

```shell
$ vim /etc/sudoers
```

11. Add btrfs plug in

```shell
$ vim /etc/mkinitcpio.conf
```

12. Add user and set password

```shell
$ useradd -m -G wheel -s /bin/zsh sada && passwd sada
```

13. Install grub

```shell
$ grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch --recheck
```

14. Generate grub configuration

```shell
$ grub-mkconfig -o /boot/grub/grub.cfg
```

1. Enable dhcpcd

```shell
$ systemctl enable dhcpcd
```

2. Enable Network Manager

```shell
$ systemctl enable NetworkManager
```

15. Exit from chroot

```shell
$ exit
```

End Install

```shell
$ umount -a && reboot
```

## Post installation 


3. Configure git

```shell
$ git config --global user.name "user@hostname"
$ git config --global user.email "user.email@example.com"
```

4. Get this repository

```shell
$ git clone https://github.com/s-akhmedoff/myenv.git
```

5. Get into it

```shell
$ cd myenv
```

6. Install zsh

```shell
$ ./zsh.sh
```

7. Install yay

```shell
$ ./yay.sh
```

8. Install all packages

```shell
$ ./pkg.sh
```

9. Other set ups

```shell
$ ./other.sh
```

