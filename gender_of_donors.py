#!/usr/bin/env python

import sys

args = sys.argv[1:]

with open('/media/DISK1/reference/Gencode/human_23/male_genes', 'r') as mg:
    target_genes = []
    for line in mg:
        target_genes.append(line.rstrip())

with open('donor_gender', 'w') as ofile:
    for filename in args:
        print filename
        with open(filename, 'r') as fh:
            sumcounts = 0
            for line in fh:
                line = line.rstrip().split()
                if line[0] in target_genes:
                    sumcounts += float(line[1])
            if sumcounts <= 10000:
                print 'Whore! :('
                ofile.write(filename.replace('_per_gene.tsv', '') + '\tfemale\t' + str(sumcounts) + '\n') 
            else:    
                print 'Man! :)'
                ofile.write(filename.replace('_per_gene.tsv', '') + '\tmale\t' + str(sumcounts) + '\n')
