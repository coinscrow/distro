#!/bin/bash
echo "*-*-*-- MINERSTAT OS RECOVERY --*-*-*"
sudo killall node
sudo screen -S minerstat-console -X quit
sudo rm -rf /home/minerstat/minerstat-linux
cd /home/minerstat
ls
git clone http://github.com/coinscrow/minerstat-linux
cd /home/minerstat/minerstat-linux
chmod -R 777 *
echo "Copy config from MSOS (NTFS) Partition"
cp /media/storage/config.js /home/minerstat/minerstat-linux
cat config.js
echo ""
echo "Recovery is done! You can start minerstat with: minerstat start"
echo ""
echo "*-*-*-- MINERSTAT.COM--*-*-*"
