#!/bin/bash

#
# The main mumbler program
#

#
# 1. Arguments
#
# mumbler <starting word> <max number of words>
#
if [ $# -ne 2 ]; then
   echo "Usage: $0 <starting word> <max number of words>"
   exit 1
 fi
starting_word=$1
max_words=$2

echo $starting_word
echo $max_words

firstword=$starting_word

#
# Find the files to search
#
rm tmplist.*
grep -E "^$starting_word " gpfs1.map  >> tmplist.gpfs1
grep -E "^$starting_word " gpfs2.map  >> tmplist.gpfs2
grep -E "^$starting_word " gpfs3.map  >> tmplist.gpfs3

cat tmplist.gpfs1 | awk '{print $NF}' >> tmplist.zipfiles.gpfs1
cat tmplist.gpfs2 | awk '{print $NF}' >> tmplist.zipfiles.gpfs2
cat tmplist.gpfs3 | awk '{print $NF}' >> tmplist.zipfiles.gpfs3

#
# Get the list of second words from each zipfile
#
sh ./scripts/get_2ndwords.sh $firstword tmplist.zipfiles.gpfs1 >> tmplist.2ndwords.gpfs1
sh ./scripts/get_2ndwords.sh $firstword tmplist.zipfiles.gpfs2 >> tmplist.2ndwords.gpfs2
sh ./scripts/get_2ndwords.sh $firstword tmplist.zipfiles.gpfs3 >> tmplist.2ndwords.gpfs3

#
# Coalesce
#
cat tmplist.2ndwords.gpfs1 > tmplist.2ndwords
cat tmplist.2ndwords.gpfs2 >> tmplist.2ndwords
cat tmplist.2ndwords.gpfs3 >> tmplist.2ndwords

cat tmplist.2ndwords | uniq -c | awk '{ print $1 "," $2 }' > tmplist.wordfreq

next_word=`python scripts/random_picker.py tmplist.wordfreq`

print $next_word


