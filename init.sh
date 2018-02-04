#!/bin/bash

while true
do 

echo "-*- BACKGROUND SERVICE -*-"
    
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

sleep 59
done
