#!/bin/bash

nsd=gpfs1

# The gpfs location
#
cd /gpfs/gpfsfpo

folder=/gpfs/gpfsfpo/$nsd

#
# Cleanup and create new directories
#
if [ -d "$folder" ]; then
rm -rf $folder
fi
mkdir $folder

#
# The file names
#
urlprefix="http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-2gram-20090715-"
urlsuffix=".csv.zip"
filestart=0
fileend=33

for i in {0..33}
do
  urlpath="$urlprefix$i$urlsuffix"
  echo $urlpath
  echo $folder
  eval "nohup wget $urlpath -P $folder/ &"
done
