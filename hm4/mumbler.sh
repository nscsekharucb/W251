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

next_words_identified=0

while [ $next_words_identified -lt $max_words ]
do
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
sh ./scripts/get_2ndwords.sh $firstword tmplist.zipfiles.gpfs1 >> tmplist.2ndwords.gpfs1 &
ssh -n -f root@gpfs2 "sh -c 'cd /gpfs/gpfsfpo/; sh ./scripts/get_2ndwords.sh $firstword tmplist.zipfiles.gpfs2 >> tmplist.2ndwords.gpfs2 &'"
ssh -n -f root@gpfs3 "sh -c 'cd /gpfs/gpfsfpo/; sh ./scripts/get_2ndwords.sh $firstword tmplist.zipfiles.gpfs3 >> tmplist.2ndwords.gpfs3 &'"

#
# Coalesce
#
while true; do
grep -q "GPFS-DONE" tmplist.2ndwords.gpfs1
if [ $? -eq 0 ]; then
   sed -i '/GPFS-DONE/d' tmplist.2ndwords.gpfs1
   break
else
   sleep 5
fi
done 

while true; do
grep -q "GPFS-DONE" tmplist.2ndwords.gpfs2
if [ $? -eq 0 ]; then
   sed -i '/GPFS-DONE/d' tmplist.2ndwords.gpfs2
   break
else
   sleep 5
fi
done 

while true; do
grep -q "GPFS-DONE" tmplist.2ndwords.gpfs3
if [ $? -eq 0 ]; then
   sed -i '/GPFS-DONE/d' tmplist.2ndwords.gpfs3
   break
else
   sleep 5
fi
done 

cat tmplist.2ndwords.gpfs1 > tmplist.2ndwords
cat tmplist.2ndwords.gpfs2 >> tmplist.2ndwords
cat tmplist.2ndwords.gpfs3 >> tmplist.2ndwords

cat tmplist.2ndwords | uniq -c | awk '{ print $1 "," $2 }' > tmplist.wordfreq

next_words_count=`wc -l < tmplist.wordfreq`
if [ $next_words_count -eq 0 ]; then
   echo "Couldnt find more words, exiting.."
   exit 1
fi
next_word=`python scripts/random_picker.py tmplist.wordfreq`

echo $next_word

first_word=$next_word
next_words_identified=`expr $next_words_identified + 1`
done
