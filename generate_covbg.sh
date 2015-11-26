#!/bin/bash

for BAM in *.sorted.bam
do
    while [ $(jobs | wc -l) -ge 4 ] ; do sleep 1 ; done
    ~/various/cov_filtering.sh $BAM & 
done
wait

bedtools intersect -wa -a ${BAM%%.sorted.bam}.bg -b *.bg > final.gtf
echo 'Fucking done'
