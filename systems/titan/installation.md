# Installation Guide

A reference of all the commands ran to set up this Arch Linux system.

`cat /sys/firmware/efi/fw_platform_size` to confirm UEFI mode

`ping archlinux.org` to verify network connection

```
fdisk -l
fdisk /dev/nvme0n1
p
g
n
<enter>
+1G
t
<enter>
1
n
<enter>
<enter>
t
<enter>
23
w
```

`mkfs.fat -F 32 -n LINUX /dev/nvme0n1p1`

```

# cryptsetup -y -v luksFormat /dev/sda2
sudo cryptsetup config /dev/sdb1 --label ROOT
# cryptsetup open /dev/sda2 root
# mkfs.ext4 /dev/mapper/root
# mount /dev/mapper/root /mnt
mount --mkdir LABEL=LINUX /mnt/boot
```

`pacstrap -K /mnt base linux linux-firmware neovim amd-ucode man-db man-pages texinfo networkmanager`
`genfstab -L /mnt >> /mnt/etc/fstab`
`arch-chroot /mnt`
`ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime`
`hwclock --systohc`
uncomment `en_US.UTF-8` from `/etc/locale.gen`, then run ` locale-gen`
create `/etc/locale.conf`: `LANG=en_US.UTF-8`
create `/etc/vconsole.conf`: `KEYMAP=us`
create `/etc/hostname`: `haven`
/etc/crypttab.initramfs: `root  LABEL=ROOT`
edit /etc/mkinitcpio.conf: `HOOKS=(base systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems fsck)`
`mkinitcpio -P`
set root password: `passwd`

- install reflector, install refind and efibootmgr
- edit /etc/xdg/reflector/reflector.conf

TODO

- refind theming
- add second, sudo user
- timedatectl
- pipewire
  - user service
- sway
  - waybar
