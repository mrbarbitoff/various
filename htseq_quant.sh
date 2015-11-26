#!/bin/bash

# This thing runs htseq-count for genomic/transcriptomic bam files

for BAM in bams/*.bam
do
    while [ $(jobs | wc -l) -ge 8 ] ; do sleep 1 ; done
    TAG1=${BAM%%.bam}; TAG2=${TAG1##bams/}; samtools view -h $BAM | htseq-count -s no -t exon - /media/DISK1/reference/Gencode/human_23/gencode_v23.gtf > ../htseq/${TAG2}.htseq.out &
done
wait
