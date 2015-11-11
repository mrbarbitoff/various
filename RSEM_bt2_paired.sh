#!/bin/bash

# This runs Bowtie2 alignment

SPECIES=$1
FQLIST=$2
FQ=$3
SAMPLES="$(cat $FQLIST)"

TMPTAG=${FQ%%.R1.fastq.gz}
TAG=${TMPTAG##fastqs/}
if [[ $SAMPLES == *$TAG* ]]; then
    gunzip -c ${TMPTAG}.R1.fastq.gz > ${TAG}.R1.fastq
    gunzip -c ${TMPTAG}.R2.fastq.gz > ${TAG}.R2.fastq
    echo $TAG
    while [ $(jobs | wc -l) -ge 4 ] ; do sleep 1 ; done
    rsem-calculate-expression --bowtie2 --estimate-rspd --forward-prob 0.5 --paired-end ${TAG}.R1.fastq ${TAG}.R2.fastq /media/DISK1/reference/RSEM/gencode_${SPECIES} RSEM/$TAG &> logs/RSEM/${TAG}.rsem.log
    rm ${TAG}*
fi
