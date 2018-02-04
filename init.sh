#!/bin/bash

while true
do 

echo "-*- BACKGROUND SERVICE -*-"
    
#HOSTNAME
HOSTNAME="$(hostname)"

#FREE SPACE in Megabyte - SDA1
STR1="$(df -hm | grep sda1 | awk '{print $4}')" 

#CPU USAGE
STR2="$(mpstat | awk '$13 ~ /[0-9.]+/ { print 100 - $13 }')"

#LOCAL IP ADDRESS
STR3="$(ip route get 1 | awk '{print $NF;exit}')"

#REMOTE IP ADDRESS
STR4="$(wget -qO- http://ipecho.net/plain ; echo)"

echo "Free Space: $STR1"
echo "CPU Usage: $STR2"
echo "Local IP: $STR3"
echo "Remote IP: $STR4"

#SEND INFO
wget -qO- "https://minerstat.com/getstatus.php?hostname=$HOSTNAME&space=$STR1&cpu=$STR2&localip=$STR3&remoteip=$STR4" ; echo

echo "-*- MINERSTAT LISTENER -*-"
RESPONSE="$(wget -qO- 'https://minerstat.com/listener.php?hostname=$HOSTNAME' ; echo)"

echo "RESPONSE: $RESPONSE"

sleep 59
done
