#!/bin/bash

#source ./list_active_host.sh

IP_ADDRESS="[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" 
MAC_ADDRESS="[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}"
cat <<EOF

Enter Packet Type:
1. ARP Request Packet
2. ARP Reply Packet
EOF

read packet_type

if [ $packet_type -gt 2 ] || [ $packet_type -lt 1 ]
then
	echo Wrong Packet Type
	exit 1
fi

S=$(/usr/local/bin/nm-tool/usr/bin/nm-tool |grep Address | tail -n +3 | head -n -1 | grep -Eo  "$IP_ADDRESS" )
h=$(/usr/local/bin/nm-tool/usr/bin/nm-tool | grep "Address"  | head -n 1 | grep -Eo "$MAC_ADDRESS" )

case $packet_type in
	1)
		echo Enter Destination IP Address
		read D
		nemesis arp -S $S -D $D -h $h
		;;
	2)	
		echo Enter Destination IP Address
		read D
		echo Enter Destination MAC Address
		read m
		nemesis arp -r -S $S -D $D -h $h -m $m
		;;
esac

