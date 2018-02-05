#!/bin/bash
echo "*-*-*-- MINERSTAT OS RECOVERY --*-*-*"
sudo killall node
sudo screen -S minerstat-console -X quit
sudo screen -S listener -X quit
sudo rm -rf /home/minerstat/minerstat-linux
cd /home/minerstat
ls
git clone http://github.com/coinscrow/minerstat-linux
cd /home/minerstat/minerstat-linux
npm install colors sleep pump request express sphp progress ascii-text-generator fkill needle parse-spawn-args readline-sync
chmod -R 777 *
echo "Copy config from MSOS (NTFS) Partition"
cp /media/storage/config.js /home/minerstat/minerstat-linux
echo ""
cat config.js
echo ""
echo ""
echo "Recovery is done!" 
sudo reboot -f
echo ""
echo "*-*-*-- MINERSTAT.COM--*-*-*"
