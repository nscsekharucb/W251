#!/bin/bash

if [ $# -ne 2 ]; then
   echo "Usage: $0 <first word> <list of zip files>"
   exit 1
fi

firstword=$1
zipfilelist=$2

while read filename
do
   zcat $filename | grep -E "^$firstword " | awk '{print $2}' 
done < $zipfilelist
