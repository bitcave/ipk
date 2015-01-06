#!/bin/sh

mnt_var=`uci add fstab mount`
uci set fstab."$mnt_var".target="/overlay"
uci set fstab."$mnt_var".device="/dev/sda1"
uci set fstab."$mnt_var".fstype="ext4"
uci set fstab."$mnt_var".options="rw,sync"
uci set fstab."$mnt_var".enabled=1
uci set fstab."$mnt_var".enabled_fsck=0
mnt_var=`uci add fstab swap`
uci set fstab."$mnt_var".device="/usr/swapfile_1"
uci commit fstab

#-----------------
# Prepare USB Stick
#-----------------
opkg update && opkg install -d ram e2fsprogs 

export LD_LIBRARY_PATH='/lib:/usr/lib:/tmp/lib:/tmp/usr/lib'
export PATH="$PATH:/tmp/bin:/tmp/sbin:/usr/sbin"
/tmp/usr/sbin/mkfs.ext4 /dev/sda1

mkdir -p /mnt/sda1
mount /dev/sda1 /mnt/sda1
tar -C /overlay -cvf - . | tar -C /mnt/sda1 -xf -
dd if=/dev/zero of="/mnt/sda1/usr/swapfile_1" bs=1M count=128
mkswap /mnt/sda1/usr/swapfile_1

echo ".. Done"
echo "do now a reboot"
echo " # reboot      "

