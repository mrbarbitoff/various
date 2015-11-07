# This runs Bowtie2 alignment of reads (notated in file) and quantifies them via RSEM

SPECIES=$1

for FQ in fastqs/*.R1.fastq.gz
do 
    while [ $(jobs | wc -l) -ge 4 ] ; do sleep 1 ; done
    ~/various/run_bowtie2.sh ${FQ%%.R1.fastq.gz} $SPECIES &
done
wait

cd bowtie2

for SAM in *.sam
do
    while [ $(jobs | wc -l) -ge 4 ] ; do sleep 1 ; done
    rsem-calculate-expression --sam $SAM /media/DISK1/reference/RSEM/gencode_${SPECIES} ../RSEM/${SAM%%.sam} & > ../logs/RSEM/${SAM%%.sam}.rsem.log
done
wait
