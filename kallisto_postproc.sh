#!/bin/bash

#samplenames file is required (column of sample descriptions to be used as annotation)

for i in *_1.fastq; do echo ${i%%_1.fastq}; done > fastqs

paste fastqs samplenames > SAMPLES

errs=`awk '{print $1}' SAMPLES`
names=`awk '{print $2}' SAMPLES`

a=( $errs )
b=( $names )

for i in `seq 0 5`; do echo ${b[$i]} > ${b[$i]}.tmp ; awk '{if (NR>1) print $4}' ${a[$i]}_kallisto_out/abundance.tsv >> ${b[$i]}.tmp; done
paste *tmp > All_counts.txt

for i in `seq 0 5`; do echo ${b[$i]} > ${b[$i]}.tmp ; awk '{if (NR>1) print $5}' ${a[$i]}_kallisto_out/abundance.tsv >> ${b[$i]}.tmp; done
paste *tmp > All_tpm.txt

paste gencode.vM6.3col_annotation.txt All_tpm.txt > exp_tpm.txt
paste gencode.vM6.3col_annotation.txt All_counts.txt > exp_counts.txt
