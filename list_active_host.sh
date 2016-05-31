#!/bin/bash

IP_ADDRESS="[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" 
MAC_ADDRESS="[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}"

my_ip_address=$(/usr/local/bin/nm-tool/usr/bin/nm-tool | grep "Address" | tail -n 1 | grep -Eo  $IP_ADDRESS )
my_mac_address=$(/usr/local/bin/nm-tool/usr/bin/nm-tool | grep "HW" |  xargs echo | grep -Eo $MAC_ADDRESS )

arp-scan --interface wlp2s0 -l |  grep -Eo "$IP_ADDRESS|$MAC_ADDRESS"
