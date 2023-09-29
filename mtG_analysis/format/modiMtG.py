#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb 13 20:41:41 2019

@author: altaic
"""

#This version of the script is written for creating rCRS based pseudo mitochondrial 
#genomes for GenoPublic Data from Genographic Project (*.plc.mt.txt).
#Modified.

import csv
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO
from sys import argv
script, ref, subs = argv
outfile = str(subs).rstrip('.for.mtG.txt') + '.event.mtG.fasta'
out = open(outfile, 'w')
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

with open(outfile, 'w') as out:
    out_seq = SeqRecord(Seq(out_string), id = str(subs).rstrip('.for.mtG.txt'), 
                 description= '')
    
    out_seq_str = out_seq
    
    SeqIO.write(out_seq_str, out, 'fasta')

