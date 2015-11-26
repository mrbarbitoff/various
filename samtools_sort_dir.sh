#!/bin/bash

for BAM in *.bam
do
    while [ $(jobs | wc -l) -ge 8 ] ; do sleep 1 ; done
    samtools sort -T tmp/${BAM##.bam} -o ${BAM%%.bam}.sorted.bam $BAM &
done
wait

rm -rf !(*.sorted.bam)

echo 'Done with that bullshit'
