#!/bin/bash


#rm gpfs1.map
#for filename in ./gpfs1/*.zip; do
#   echo $filename
#   zcat $filename | awk '{print $1}' | uniq | awk '{print $1 "  gpfs1  " "'"$filename"'"}' >> gpfs1.map
#done

#rm gpfs2.map
#for filename in ./gpfs2/*.zip; do
#   echo $filename
#   zcat $filename | awk '{print $1}' | uniq | awk '{print $1 "  gpfs2  " "'"$filename"'"}' >> gpfs2.map
#done

rm gpfs3.map
for filename in ./gpfs3/*.zip; do
   echo $filename
   zcat $filename | awk '{print $1}' | uniq | awk '{print $1 "  gpfs3  " "'"$filename"'"}' >> gpfs3.map
done
