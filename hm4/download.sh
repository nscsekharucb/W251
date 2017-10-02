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

# The gpfs location
#
cd /gpfs/gpfsfpo

#
# Cleanup and create new directories
#
if [ -d "gpfs$nsdnum" ]; then
rm -rf /gpfs/gpfsfpo/gpfs$nsdnum
mkdir /gpfs/gpfsfpo/gpfs$nsdnum
fi

#
# The file names
#
urlprefix="http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-2gram-20090715-"
urlsuffix=".csv.zip"
filestart=`expr 33 * ($nsdnum - 1) + 1`
fileend=`expr 33 * ($nsdnum)`

for i in {0..99}
do
  urlpath="$urlprefix$i$urlsuffix"
  case $i in
    [0-33]*)
      folder="gpfs1"
      ;;
    [34-66]*)
      folder="gpfs2"
      ;;
    [67-99]*)
      folder="gpfs3"
      ;;
  esac
  echo $urlpath
  echo $folder
  eval "nohup wget $urlpath -P ./$folder/ &"
done
