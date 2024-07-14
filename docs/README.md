# Installing Arch Linux

cat /sys/firmware/efi/fw_platform_size

ip link

ping archlinux.org

fdisk -l
fdisk /dev/nvme0n1

cryptsetup -y -v luksFormat /dev/nvme0n1p5

sudo cryptsetup config /dev/nvme0n1p5 --label LINUX

cryptsetup open /dev/nvme0n1p5 root
mkfs.ext4 /dev/mapper/root
mount /dev/mapper/root /mnt

mount LABEL=BOOT --mkdir /mnt/boot

pacstrap -K /mnt base linux linux-firmware amd-ucode nano vim neovim networkmanager reflector sudo refind efibootmgr man-db man-pages texinfo

arch-chroot /mnt

install amd-ucode
crypttab.initramfs -> `root     LABEL=LINUX`
adjust /etc/mkinitcpio.conf

install networkmanager

## TODO

- set timezone
- enable systemd-timesyncd
- enable networkmanager service
- NetworkManager
- Reflector

- Non sudo user
- install paru and paru --gendb
- Timesyncd
- REFIND entry and theming

- Pipewire polkit
- XDG-user-dirs XDG-portals
- Sway
- VPN!!!!!
- Fontconfig jetbrains Nerd FOnt, install roboto and apple emoji
- firefox

- Qemu virt-manager
-
- spotify
-
- Swaylock en swaybg, hotkeys for lock sleep shutdown
- TLP battery saver
- Waybar customization
