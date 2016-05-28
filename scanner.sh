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
EOF

	read scan_type
	
	#Check if entered scan type is correct
	if [ $scan_type -gt 2 ] || [ $scan_type -lt 1 ]
	then
		echo Wrong Scan Type
		exit 1
	fi

	#Get target type
	cat <<EOF

Choose Target Type:
1. Single IP Address Single Port
2. Single IP Address Multiple Port
3. Multiple IP Address Single Port
4. Multiple IP Address Multiple Port
EOF
	read target_type
	
	if [ $target_type -lt 1 ] || [ $target_type -gt 4 ]
	then 
		echo Wrong Target Type
		exit 2
	fi

	#If Scan Type is Ful TCP Scan
	if [ $scan_type = 1 ]
	then 
		scan_type=T
	#Otherwise SYN Scan
	else
		scan_type=S
	fi

	case $target_type in
		1)
			echo Enter IP Address
			read ip
			echo Enter Port
			read port
			echo ""
			;;
		2)
			echo Enter Range of IP Address
			read ip
			echo Enter Port
			read port 
			echo ""
			;;
		3)	
			echo Enter IP Address
			read ip
			echo Enter Port Range
			read port 
			echo ""
			;;
		4)
			echo Enter Range of IP Address
			read ip
			echo Enter Port Range
			read port 
			echo ""
			;;
	esac
	nmap -s$scan_type $ip -p $port | tail -n +4 | head -n -2	
fi
