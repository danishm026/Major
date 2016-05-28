#!/bin/bash

cat <<EOF
Enter Packet Type:
1. ARP Request Packet
2. ARP Reply Packet
EOF

read packet_type

if [ $packet_type -gt 3 ] || [ $packet_type -lt 1 ]
then
	echo Wrong Packet Type
	exit 1
fi

case $packet_type in
	1)
		echo Enter Sender IP Address
		read S
		echo Enter Destination IP Address
		read D
		echo Enter Source MAC Address
		read h
		nemesis arp -S $S -D $D -h $h
		;;
	2)	echo Enter Sender IP Address
		read S
		echo Enter Destination IP Address
		read D
		echo Enter Source MAC Address
		read h
		echo Enter Destination MAC Address
		read m
		nemesis arp -r -S $S -D $D -h $h -m $m
		;;
esac

