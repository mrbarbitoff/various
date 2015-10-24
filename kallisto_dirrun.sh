#!/bin/bash


# This runs kallisto quant for all fastq.gz files (must be run from directory with series)

SPECIES=$1
PAIRED=$2

if [[ $PAIRED = "" || $SPECIES = ""  ]]; then
    echo "usage kallisto_dirrun.sh vXX p/s"
elif [ $PAIRED = "p" ]; then
    for FN in fastqs/*.R1.fastq.gz
    do
        while [ $(jobs | wc -l) -ge 8 ] ; do sleep 1 ; done
        TMPTAG=${FN%%.R1.fastq.gz}
        TAG=${TMPTAG#fastqs/}
        echo $TAG
        gunzip -c fastqs/${TAG}.R1.fastq.gz > ${TAG}.R1.fastq
        gunzip -c fastqs/${TAG}.R2.fastq.gz > ${TAG}.R2.fastq
        kallisto quant -i /media/DISK1/reference/Kallisto_indexes/gencode.${SPECIES}.index -o ${TAG}_kallisto_out ${TAG}.R1.fastq ${TAG}.R2.fastq
        rm ${TAG}.R1.fastq
        rm ${TAG}.R2.fastq &
    done
    wait
elif [ $PAIRED = "s" ]; then
    for FN in fastqs/*.fastq.gz
    do
        while [ $(jobs | wc -l) -ge 8 ] ; do sleep 1 ; done
        TMPTAG=${FN%%.fastq.gz}
        TAG=${TMPTAG#fastqs/}
        echo $TAG
        gunzip -c fastqs/${TAG}.fastq.gz > ${TAG}.fastq
        kallisto quant -i /media/DISK1/reference/Kallisto_indexes/gencode.${SPECIES}.index -o kallisto/${TAG}_kallisto_out --single ${TAG}.fastq -l 190 -s 10 &> kallisto_logs/${TAG}.kallisto.log
        rm ${TAG}.fastq &
    done
    wait
fi
    
echo Done

    
