#!/bin/bash
sudo apt-get update;
sudo apt-get install -y wget git nano mc mdadm smartmontools hdparm gdisk;
sudo mdadm --zero-superblock --force /dev/sd{b,c,d,e};
sudo mdadm --create --verbose /dev/md0 -l 5 -n 4  /dev/sd{b,c,d,e};
sudo mdadm -D /dev/md0;
sudo mdadm /dev/md0 --fail /dev/sde;
sudo mdadm /dev/md0 --remove /dev/sde;
sudo mdadm /dev/md0 --add /dev/sde;
sudo  parted -s /dev/md0 mklabel gpt;
sudo parted /dev/md0 mkpart primary ext4 0% 10%;
sudo parted /dev/md0 mkpart primary ext4 10% 20%;
sudo parted /dev/md0 mkpart primary ext4 20% 30%;
sudo parted /dev/md0 mkpart primary ext4 30% 40%;
sudo parted /dev/md0 mkpart primary ext4 40% 100%;
for i in $(seq 1 5); do sudo mkfs.ext4 /dev/md0p$i; done
sudo  mkdir -p /raid/part{1,2,3,4,5};
for i in $(seq 1 5); do sudo mount /dev/md0p$i /raid/part$i; done
sudo -i
 echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
 mdadm --detail --scan --verbose | awk '/ARRAY/ {print}'
su vagrant
