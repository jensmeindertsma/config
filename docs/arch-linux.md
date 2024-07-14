# Installing Arch Linux

## Downloading the installer

First, get yourself an installation image from [the Arch Linux Downloads page](https://archlinux.org/download/). You'll want to use a mirror close to your geographical locations and make sure to grab the `archlinux-[version]-x86_64.iso` and `archlinux-[version]-x86_64.iso.sig`, where `version` is the same in both files and looks something like `2024.07.01`.

Then, verify the image authenticity using the `.sig` file and the GnuPG tool:

```
$ gpg --keyserver-options auto-key-retrieve --verify archlinux-[version]-x86_64.iso.sig
```

The output should look something like:

```
gpg: assuming signed data in 'archlinux-2024.07.01-x86_64.iso'
gpg: Signature made Mon 01 Jul 2024 08:11:25 PM CEST
gpg:                using EDDSA key 3E80CA1A8B89F69CBA57D98A76A5EF9054449A5C
gpg:                issuer "pierre@archlinux.org"
gpg: /home/jens/.gnupg/trustdb.gpg: trustdb created
gpg: key 7F2D434B9741E8AC: public key "Pierre Schmitz <pierre@archlinux.org>" imported
gpg: key 76A5EF9054449A5C: public key "Pierre Schmitz <pierre@archlinux.org>" imported
gpg: Total number processed: 2
gpg:               imported: 2
gpg: no ultimately trusted keys found
gpg: Good signature from "Pierre Schmitz <pierre@archlinux.org>" [unknown]
gpg: WARNING: The key's User ID is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 3E80 CA1A 8B89 F69C BA57  D98A 76A5 EF90 5444 9A5C
```

`gpg` tells me that the ISO file has a valid signature supposedly belonging to Pierre Schmitz. You should verify manually the "Primary key fingerprint" on the last line matches the public key associated with Pierre Schmitz on [the Arch Linux Developers page](https://archlinux.org/people/developers/).

If you are installing Arch Linux on a Virtual Machine, you can use this ISO file to boot. If you are installing onto real hardware, follow these steps:

1. Burn the image to a USB drive with a tool like [Rufus](https://rufus.ie/en/)
2. Eject the USB
3. Insert the USB into the computer upon which Arch Linux should be installed.
4. Boot the device and select the USB in the boot menu.

## Getting started

I always start with the following command:

```
$ cat /sys/firmware/efi/fw_platform_size
```

If this command returns `64`, the system is running in UEFI mode, which is recommended and is what my tutorial will apply to.

Next we check the network status using `ip link`:

```
$ ip link

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp10s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DFEFAULT group default qlen 1000
    link/ether 74:35:c3:3c:75:b0 brd ff:ff:ff:ff:ff:ff
4. wlan0 <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DORMANT group default qlen 1000
```

Then run the following to verify network connectivity:

```
$ ping archlinux.org

PING archlinux.org (95.217.163.246) 56(84) bytes of data.
64 bytes from archlinux.org (95.217.163.246): icmp_seq=1 ttl=52 time=35.8 ms
64 bytes from archlinux.org (95.217.163.246): icmp_seq=2 ttl=52 time=38.8 ms
```

## TODO

- fdisk -l, figure out drive name
- create EFI system partition 1gb
- create linux root x86-65 partition
- mkfs.fat -F 32 -n BOOT {system_partition}
- cryptsetup -y -v luksFormat {root_partiition}
- cryptsetup config {root_partition} --label ROOT
- cryptsetup open /dev/nvme0n1p5 root
- mkfs.ext4 /dev/mapper/root
- mount /dev/mapper/root /mnt
- mount LABEL=BOOT --mkdir /mnt/boot
- pacstrap -K /mnt base linux linux-firmware man-db man-pages texinfo vim
- genfstab -L /mnt >> /mnt/etc/fstab
- arch-chroot /mnt

- - swap file: https://linuxize.com/post/create-a-linux-swap-file/

- set timezone: `ln -sf /usr/share/zoneinfo/Region/City /etc/localtime`
- `hwclock --systohc`
- enable systemd-timesyncd
- Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8
- `locale-gen`
- `echo "LANG=en_US.UTF-8" > /etc/locale.conf`
- `echo "KEYMAP=us" > /etc/vconsole.conf`
- `echo "{hostname}" > /etc/hostname`

- install either amd-ucode or intel-ucode

- create crypttab.initramfs -> `root     LABEL=ROOT`
- customize /etc/mkinitcpio.conf: `HOOKS=(base systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems fsck)`
- mkinitcpio -P

- install refind `refind-install`
- make sure it is 1st in boot order with efibootmgr
- remove `refind-linux.conf` and customize refind.conf to set manual boot stanzas

- systemctl enable NetworkManager
- customize /etc/xdg/reflector/reflector.conf
- if on a wired network systemctl enable reflector

- set the root password: `passwd`

- reboot and set secure boot to setu[p ]

- sbctl

- visudo allow wheel group
- `useradd -m -G wheel jens`
- `passwd` jens
- log out and log in as jens

- Pipewire polkit
- XDG-user-dirs XDG-portals

- install nix, git clone
- make sure all packages are installed locally, check wyvern
- apply config
- install roboto and apple emoji(paru)
- firefox

- greetd

- Qemu virt-manager
- VPN!!!!!
- spotify
- bluetooth
- signal
