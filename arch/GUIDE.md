# 													GUIDE
## Installation

* **Verify the boot mode**

```shell
$ ls /sys/firmware/efi/efivars
```


* **Set Net Time**

```shell
$ timedatectl set-ntp true
```

* **Verify GPT**

```shell
$ gdisk /dev/sda
```

* **Make Partitions on disk**

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

* **Make file systems**

```shell
$ mkfs.fat -F32 /dev/sda1 			# EFI
$ mkfs.btrfs -f -L root /dev/sda2	# Linux Root
$ mkfs.btrfs -f -L home /dev/sda3	# Linux Home
$ mkswap /dev/sda4					# Swap
```

* **Mount root and create sub volume**

```shell
$ mount /dev/sda2 /mnt && btrfs sub cr /mnt/@ && umount /dev/sda2
```

* **Mount home and create sub volume**

```shell
$ mount /dev/sda3 /mnt && btrfs sub cr /mnt/@home && umount /dev/sda3
```

* **Merge Mounts**

```shell
$ mount -o noatime,commit=120,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/sda2 /mnt

$ mkdir -p /mnt/home
$ mount -o noatime,commit=120,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/sda3 /mnt/home

$ mkdir -p /mnt/boot/efi
$ mount /dev/sda1 /mnt/boot/efi

$ swapon /dev/sda4
```

* **Update Mirror list**

```shell
$ reflector --country 'Russia,Kazakhstan' --protocol http --protocol https --sort rate --latest 50 --save /ect/pacman.d/mirrorlist
```

* **Add third party repository**
  - Receive and sign keys => Add repository server

```shell
$ pacman-key --recv-key B545E9B7CD906FE3 
$ pacman-key --lsign-key B545E9B7CD906FE3
```


``` shell
$ vim /etc/pacman.conf
[andontie-aur]
Server = https://aur.andontie.net/$arch
```

* **Install in new root**

```shell
$ pacman -Syu
$ pacstrap /mnt base base-devel linux-firmware linux-xanmod linux-xanmod-headers e2fsprogs dosfstools dhcpcd vim man-db openssh man-pages tldr reflector fakeroot zsh grub os-prober mtools efibootmgr curl git btrfs-progs networkmanager dialog
```

* **Generate file system table**

```shell
$ genfstab -U -p /mnt >> /mnt/etc/fstab
```

* **Change root**

```shell
$ arch-chroot /mnt
```

### Inside the chroot

* **Local time**

```shell
$ ln -sf /usr/share/zoneinfo/Asia/Tashkent /etc/localtime
```

* **Sync sys clock**

```shell
$ hwclock --systohc
```

* **Uncomment en_US.UTF-8**

```shell
$ vim /etc/locale.gen
```

* **Generate localization**

```shell
$ locale-gen
```

* **Set host name**

```shell
$ echo "host-arch" > /etc/hostname
```

* **Set Locale Language**

```shell
$ echo LANG=en_US.UTF-8 > /etc/locale.conf
```

* **Set environment language**

```shell
$ export LANG=en_US.UTF-8
```

* **Set hosts**

```shell
$ vim /etc/hosts
127.0.0.1	localhost
::1		localhost
```

* **Set root password**

```shell
$ passwd
```

* **Uncomment wheel group**

```shell
$ vim /etc/sudoers
```

* **Add btrfs plug in**

```shell
$ vim /etc/mkinitcpio.conf
```

* **Add user and set password**

```shell
$ useradd -m -G wheel -s /bin/zsh sada && passwd sada
```

* **Install grub**

```shell
$ grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch --recheck
```

* **Generate grub configuration**

```shell
$ grub-mkconfig -o /boot/grub/grub.cfg
```

* **Enable DHCP**

```shell
$ systemctl enable dhcpcd
```

* **Enable Network Manager**

```shell
$ systemctl enable NetworkManager
```

* Enable SSH

```shell
$ systemctl enable sshd
```

* **Exit from chroot**

```shell
$ exit
```

## Installing End

```shell
$ umount -a && reboot
```

## Post installation 

* **Configure git**

```shell
$ git config --global user.name "Sodikjon"
$ git config --global user.email "sodikjon.akhmedoff@gmail.com"
```

* **Get this repository**

```shell
$ git clone https://github.com/s-akhmedoff/myenv.git
```

* **Get into it**

```shell
$ cd myenv
```

* **Install zsh**

```shell
$ ./zsh.sh
```

* **Install yay**

```shell
$ ./yay.sh
```

* **Install all packages**

```shell
$ ./pkg.sh
```

* **Other set up**

```shell
$ ./other.sh
```

