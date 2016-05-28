#!/bin/bash

address=$(source ./list_active_host.sh )

for add in $address
do
echo $add
done
