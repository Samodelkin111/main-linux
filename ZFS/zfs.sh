sudo -i
apt-get update;
apt-get install -y curl wget git nano mc zfsutils-linux
lsblk;
zpool create test1 mirror /dev/sdb /dev/sdc;
zpool create test2 mirror /dev/sdd /dev/sde;
zpool create test3 mirror /dev/sdf /dev/sdg;
zpool create test4 mirror /dev/sdh /dev/sdi;
zfs set compression=lzjb test1;
zfs set compression=lz4 test2;
zfs set compression=gzip-9 test3;
zfs set compression=zle test4;
zfs get all | grep compression;
for i in {1..4}; do wget -P /test$i https://gutenberg.org/cache/epub/2600/pg2600.converter.log; done
ls -l /otus*;
zfs list; 
zfs get all | grep compressratio | grep -v ref;
wget -O archive.tar.gz --no-check-certificate 'https://drive.usercontent.google.com/download?id=1MvrcEp-WgAQe57aDEzxSRalPAwbNN1Bb&export=download';
tar -xzvf archive.tar.gz;
zpool import -d zpoolexport/
zpool import -d zpoolexport/ otus
zpool status;
zfs get available otus;
zfs get readonly otus;
zdb | grep type;
zfs get recordsize otus;
zfs get compression otus;
zfs get checksum otus;
wget -O otus_task2.file --no-check-certificate 'https://drive.usercontent.google.com/download?id=1wgxjih8YZ-cqLqaZVa0lA3h3Y029c3oI&export=download';
zfs receive otus/test@today < otus_task2.file;
cat /otus/test/task1/file_mess/secret_message;
exit
