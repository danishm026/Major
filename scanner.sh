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
Menu:
1. Full TCP Scan
2. SYN Scan
3. ACK Scan
4. UDP Scan
5. Ping Scan 
6. Aggressive Scan
7. Host Discovery without port scan 
8. Scan all hosts irrespective of whether they are up or not 
9. Simultaneous UDP and TCP scan
10.Service Detection
EOF
	echo 
	echo Enter Choice
	read scan_type
	
	#Check if entered scan type is correct
	if [ $scan_type -gt 10 ] || [ $scan_type -lt 1 ]
	then
		echo Wrong Scan Type
		exit 1
	fi
	echo 
	echo Enter IP Address
	read ip

	case $scan_type in
		1) 
			nmap -sT $ip | tail -n +3  | sed s/Nmap/Scanner/g
			;;
		2)
			nmap -sS $ip  | tail -n +3  | sed s/Nmap/Scanner/g
			;;
		3)	
			nmap -sA $ip  | tail -n +3  | sed s/Nmap/Scanner/g
			;;
		4)	
			nmap -sU $ip  | tail -n +3  | sed s/Nmap/Scanner/g
			;;
		5)	
			nmap -PE $ip   | tail -n +3  | sed s/Nmap/Scanner/g
			;;
		6)	
			nmap -sS -A $ip	| tail -n +3 | head -n -2 | sed s/Nmap/Scanner/g | sed s/Nmap/Scanner/g | sed 's|OS and Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .||g' | sed 's|(If you know what OS is running on it, see http://nmap.org/submit/ ).||g'
			;;
		7)
			nmap -sn $ip | tail -n +3 | sed s/Nmap/Scanner/g
			;;
		8)
			nmap -Pn $ip | tail -n +3 | sed s/Nmap/Scanner/g
			;;
		9)
			nmap -sS -sU $ip | tail -n +3 | sed s/Nmap/Scanner/g
			;;
		10)
			nmap -sV $ip | tail -n +3 | head -n -2 | sed s/Nmap/Scanner/g
		esac
fi
