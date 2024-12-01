#! /bin/bash
sudo -i
apt-get update;
apt-get install -y nfs-kernel-server curl wget git nano mc
echo "NFS server setting"
mkdir -p /srv/share/upload;
chown -R nobody:nogroup /srv/share;
chmod 0777 /srv/share/upload;
cat <<EOF > 
/etc/exports /srv/share 192.168.1.100/32(rw,sync,root_squash,no_subtree_check)
EOF
exportfs -r;
exportfs -s;
touch /srv/share/upload test-file;
exit;
