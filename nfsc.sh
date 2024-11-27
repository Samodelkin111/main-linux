#! /bin/bash
sudo -i;
apt update;
apt install -y nfs-common curl wget git nano mc
echo "NFS cliet setting"
echo "192.168.1.100:/srv/share/ /mnt nfs vers=3,noauto, x-systemd.automount 0 0" >> /etc/fstab;
root@test-nfsc:~# systemctl daemon-reload;
root@test-nfsc:~# systemctl restart remote-fs.target;
mount | grep mnt
touch /mnt/upload/client_file;
ls -l /mnt/upload;
exit
