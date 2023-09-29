#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb 13 20:41:41 2019

@author: altaic
"""

#The final version of the script for creating rCRS based pseudo mitochondrial 
#genomes for Kazak Individuals from Jetisuu (*.neo.mt.txt).
#Modified.

import csv
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO
from sys import argv
script, ref, subs = argv
outfile = str(subs).rstrip('.neo.mtG.txt') + '.mtG.fasta'
out = open(outfile, 'wb')
seq_string = []
with open(ref, "r") as infile:
    for k, line in enumerate(infile):
    
            if ">" in line:
                pass
            else:
                seq_string.append(line.strip("\n"))

seq_str = "".join(seq_string)
print (len(seq_str))
new_indexed_seq=list(seq_str)
with open(subs) as subs_file:
    subs_reader=csv.reader(subs_file, delimiter='\t')
    for line in subs_reader:
        pos = (int(line[0]) - 1)
        base = line[1]
        original_base=seq_str[pos]
        
        
        new_indexed_seq[pos]=base

out_string="".join(new_indexed_seq)

with open(outfile, 'wb') as out:
    out_seq = SeqRecord(Seq(out_string), id = str(subs).rstrip('.neo.mtG.txt'), 
                 description= '')
    SeqIO.write(out_seq, out, 'fasta')

