#!/bin/bash

while true
do 

echo "-*- BACKGROUND SERVICE -*-"
    
#HOSTNAME
TOKEN="$(cat /media/storage/config.js | grep 'global.accesskey' | sed 's/global.accesskey =//g' | sed 's/;//g')"
WORKER="$(cat /media/storage/config.js | grep 'global.worker' | sed 's/global.worker =//g' | sed 's/;//g')"

#FREE SPACE in Megabyte - SDA1
STR1="$(df -hm | grep sda1 | awk '{print $4}')" 

#CPU USAGE
STR2="$(mpstat | awk '$13 ~ /[0-9.]+/ { print 100 - $13 }')"

#LOCAL IP ADDRESS
STR3="$(ip route get 1 | awk '{print $NF;exit}')"

#REMOTE IP ADDRESS
STR4="$(wget -qO- http://ipecho.net/plain ; echo)"

echo ""
echo "-*- $TOKEN $WORKER -*-"
echo "Free Space: $STR1"
echo "CPU Usage: $STR2"
echo "Local IP: $STR3"
echo "Remote IP: $STR4"
echo ""

#SEND INFO
wget -qO- "https://minerstat.com/getstatus.php?token=$TOKEN&worker=$WORKER&space=$STR1&cpu=$STR2&localip=$STR3&remoteip=$STR4" ; echo

echo "-*- MINERSTAT LISTENER -*-"
RESPONSE="$(wget -qO- "https://minerstat.com/listener.php?token=$TOKEN&worker=$WORKER" ; echo)"

echo "RESPONSE: $RESPONSE"

if [ $RESPONSE = "REBOOT" ]; then
sudo reboot -f
fi

if [ $RESPONSE = "SHUTDOWN" ]; then
sudo shutdown -h now
fi

if [ $RESPONSE = "RESTART" ]; then	
cd /home/minerstat/minerstat-linux		
node stop		
sleep 3		
echo "RESTARTING .."
sudo -u minerstat -s
sleep 1
screen -A -m -d -S minerstat-console sudo sh /home/minerstat/minerstat-linux/start.sh
echo ""		
fi

if [ $RESPONSE = "null" ]; then
echo "No remote command pending..";
fi

sleep 40
done
