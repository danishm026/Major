#!/bin/bash

nmap "$@" | tail -n +3 | sed s/Nmap/Scanner/g | sed 's|OS and Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .||g' | sed 's|(If you know what OS is running on it, see http://nmap.org/submit/ ).||g'
