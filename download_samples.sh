#!/bin/bash

# This downloads whole series using tab-delimited format file

SAMPLES=$1

links=`awk -F "\t" '{ if (NR > 1)  print $31 }' $SAMPLES`

for link in $links
do
    wget $link
done

awk -F "\t" '{ if (NR > 1)  print $30 }' $SAMPLES > errs.txt
awk -F "\t" '{ if (NR > 1)  print $1 }' $SAMPLES > samps.txt
paste errs.txt samps.txt > SAMPLES
sort -u SAMPLES
rm errs.txt samps.txt
