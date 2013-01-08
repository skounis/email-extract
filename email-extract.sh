#!/bin/bash

#
# This shell script extracts all the email address from all the .txt files 
# that are located in the ./input folder. For each one input .txt file, 
# an output .out file is created into the ./output folder. A merged output file
# is created as well. 
#
# References
#  http://www.cyberciti.biz/faq/bash-loop-over-file/
#  http://bytes.com/topic/unix/answers/648158-extract-email-addresses-big-file
#
FILES=input/*
OUTPUT="./output"

if [ -d "$OUTPUT" ]; then
    printf '%s\n' "Removing ($OUTPUT)"
    rm -rf "$OUTPUT"
fi

mkdir -p $OUTPUT
touch ./output/merged.out

for f in $FILES
do
  name=$(basename $f ".txt")
  echo "Processing $f file... [$name]"
  perl -wne'while(/[\w\.\-]+@[\w\.\-]+\w+/g){print "$&\n"}' $f | sort -u > $OUTPUT/$name.out 
  #echo "[--- $name.out ---]" >> $OUTPUT/merged.out 
  cat output/$name.out >> $OUTPUT/merged.out  
done