#!/bin/bash


#Put kallisto's and salmon's output for comparisons

for FD in salmon/*; do TAG=${FD##salmon/} awk 'NR >9 { print }' < $FD/quant.sf > ~/barbitoff/salmon/$TAG; done
for FD in kallisto/*_kallisto_out; do TAG=${FD##kallisto/} sudo cp $FD/abundance.tsv ~/barbitoff/kallisto/${TAG%%_kallisto_out}; done

R salmon_kallisto_cors.r
