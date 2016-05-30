#!/bin/bash

#Disable interactive  mode
interactive_mode=false

while getopts "i" opt
do
	case $opt in
	i)
		interactive_mode=true
		;;
	esac
done

#Interactive mode
if [[ $interactive_mode = true ]]
then
	#Get Scan Type
	cat <<EOF
Choose Scan type:
1. Full TCP Scan
2. SYN Scan
3. Ping Scan
4. Aggressive Scan
5. Scan without ping
EOF

	read scan_type
	
	#Check if entered scan type is correct
	if [ $scan_type -gt 4 ] || [ $scan_type -lt 1 ]
	then
		echo Wrong Scan Type
		exit 1
	fi
	echo 
	echo Enter IP Address
	read ip
	echo Enter port
	read port

	case $scan_type in
		1) 
			nmap -sT $ip -p $port
			;;
		2)
			nmap -sS $ip -p $port
			;;
		3)
			nmap -sS -PP -PE -PS $ip
			;;
		4)
			nmap -sS -A $ip	
			;;
		esac
fi
