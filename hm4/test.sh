#!/bin/bash

#
# Check the arguments
#
if [ "$#" -ne 1 ]; then
   echo "Usage: $0 <nsdnum>"
   exit 1
fi

nsdnum=$1
if [ $nsdnum -lt 1 ]; then
   echo " NSD Number not in range "
   exit 1
fi

if [ $nsdnum -gt 3 ]; then
   echo " NSD Number not in range "
   exit 1
fi

filestart=`expr 33 * $nsdnum - 1 + 1`
fileend=`expr 33 * ($nsdnum)`

echo $filestart
echo $fileend
