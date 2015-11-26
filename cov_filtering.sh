#!/bin/bash

IFILE=$1
TAG=${IFILE%%.sorted.bam}
echo $TAG

bedtools genomecov -bg -split -ibam $IFILE | awk '$4 > 9' > ${TAG}.bg
~/various/join_bg.py ${TAG}.bg
bedtools intersect -wa -f 0.50 -a genes.gtf -b ${TAG}.gtf | sort -k 10 -u | grep 'protein_coding' | sort > ${TAG}.out.gtf
#bedtools intersect -wa -a $IFILE -b ${TAG}.out.gtf > ${TAG}.protein_coding.bam
rm ${TAG}.bg ${TAG}.gtf #${TAG}.out.gtf
