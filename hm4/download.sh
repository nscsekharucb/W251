#!/bin/bash

# The gpfs location
#
cd /gpfs/gpfsfpo

#
# Cleanup and create new directories
#
if [ -d "gpfs1" ]; then
rmdir /gpfs/gpfsfpo/gpfs1
fi
if [ -d "gpfs2" ]; then
rmdir /gpfs/gpfsfpo/gpfs2
fi
if [ -d "gpfs3" ]; then
rmdir /gpfs/gpfsfpo/gpfs3
fi

mkdir gpfs1 gpfs2 gpfs3

#
# The file names
#
urlprefix="http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-2gram-20090715-"
urlsuffix=".csv.zip"
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
