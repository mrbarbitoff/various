# This runs Bowtie2 alignment

TMPTAG=$1
SPECIES=$2
SAMPLES="$(cat SAMPLES_BT2)"

TAG=${TMPTAG##fastqs/}

if [[ $SAMPLES == *$TAG* ]]; then
    bowtie2 -x /media/DISK1/reference/Bowtie2/gencode_v23 -1 fastqs/${TAG}.R1.fastq.gz -2 fastqs/${TAG}.R2.fastq.gz -S bowtie2/${TAG}.sam &> logs/Bowtie2/${TAG}.bt2.log
fi

