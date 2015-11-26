#!/usr/bin/env python

import sys

inp_files = sys.argv[1:]

for bg in inp_files:
    out = bg.replace('.bg', '.gtf')
    with open(out, 'w') as ofile:
        with open(bg, 'r') as ifile:
            starting = None
            ending =  None
            for line in ifile:
                content = line.split()
                stoffset = int(content[1])
                endoffset = int(content[2])
                if starting is None:
                    starting = stoffset
                    ending = endoffset
                if stoffset == ending or stoffset == ending + 1:
                    ending = endoffset
                    continue
                if stoffset != ending or stoffset != ending + 1:
                    ofile.write('\t'.join([content[0], str(starting), str(ending)])+ '\n')
                    starting = stoffset
                    ending = endoffset
            ofile.write('\t'.join([content[0], str(starting), str(ending)]))

