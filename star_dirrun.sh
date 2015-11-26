#!/bin/bash

# This shit aligns samples in condition file using STAR and HTSeq

SPECIES=$1
FQLIST=$2
SAMPLES="$(cat $FQLIST)"

for FQ in fastqs/*.R1.fastq.gz
do
    TAG1=${FQ%%.R1.fastq.gz}
    TAG2=${TAG1##fastqs/}
    if [[ $SAMPLES == *$TAG2* ]]; then
        ~/various/star_align.sh $TAG2 $SPECIES 76 ${TAG1}.R1.fastq.gz ${TAG1}.R2.fastq.gz
    fi
done


for SO in *_STAR
do
    cd $SO
    mv *.tr.bam ../STAR/tr_bams/
    mv *.bam ../STAR/bams/
    mv * ../logs/STAR/
    cd ..
    rm -r $SO
done
