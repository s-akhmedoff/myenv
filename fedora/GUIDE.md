# Fedora Post-Install

+ Tweak DNF

``` shell
./dnf.sh
```
+ Add repos

```shell
./repos.sh
```
+ Install packages

``` shell
./pkgs.sh
```

+ Install flats 

```shell
./flatpaks.sh
``` 

+ Tweak ZSH

``` shell
./zsh.sh
```

+ Other settings

```shell
./other.sh
```

## btrfs filesystem optimizations

Fedora has not optimized the mount options for btrfs yet. I have found that there is some general agreement on the following mount options if you are on a SSD or NVME:

	   1. ssd: use SSD specific options for optimal use on SSD and NVME
	   2. noatime: prevent frequent disk writes by instructing the Linux kernel not to store the last access time of files and folders
   	   3. space_cache: allows btrfs to store free space cache on the disk to make caching of a block group much quicker
   	   4. commit=120: time interval in which data is written to the filesystem (value of 120 is taken from Manjaro’s minimal iso)
   	   5. compress=zstd: allows to specify the compression algorithm which we want to use. btrfs provides lzo, zstd and zlib compression algorithms. Based on some Phoronix test cases, zstd seems to be the better performing candidate.
   	   6. discard=async: Btrfs Async Discard Support Looks To Be Ready For Linux 5.6

Enable auto trim SSD

```shell 
sudo systemctl enable fstrim.timer
```

## SSH keys

Generate keygent

``` shell
ssh-keygen -t ed25519 -C "sodikjon.akhmedoff@gmail.com"
```

Add to shh agent

``` shell
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

## Other ...