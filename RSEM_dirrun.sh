#!/bin/bash

# This runs Bowtie2 alignment of reads (notated in file) and quantifies them via RSEM

SPECIES=$1
FQLIST=$2

for FQ in fastqs/*.R1.fastq.gz
do
    while [ $(jobs | wc -l) -ge 4 ] ; do sleep 1 ; done
    ~/various/RSEM_bt2_paired.sh $SPECIES $FQLIST $FQ &
done
wait

echo Done
