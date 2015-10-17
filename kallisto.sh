#!/bin/bash

TAG=$1
SPECIES=$2
READ1=$3
READ2=$4
INDEX=""

if [[ $SPECIES == gencode_vM6 ]]
then
  INDEX="/media/user/DISK1/reference/Kallisto_indexes/gencode.vM6.index"
else if [[ $SPECIES == gencode_v23 ]]
then
  INDEX="/media/user/DISK1/reference/Kallisto_indexes/gencode.v23.index"
else
  echo "What are you doing? Only acceptable options are gencode_vM6 and gencode_v23 right now!"
fi

kallisto quant -i $INDEX -o ${TAG}_kallisto_out $READ1 $READ2 >& $TAG.log 
