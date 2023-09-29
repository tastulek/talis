#!/usr/bin/env python
# coding: utf-8

# In[ ]:
import sys

def rename_fasta(file):
    file = sys.argv[1]
    print(file)
    with open(file, 'r', encoding = 'utf-8') as datafile:
        seqStr = datafile.read()
        seqList = seqStr.split('\n')
        seqHead = seqList[0]
        seqBody = ''.join(seqList[1:])
        datafile.close()
        
        neo_seqHead = seqHead + ' [location=mitochondrion]'
        
        
        with open(file, 'w', encoding = 'utf-8') as fastaFile:
            fastaFile.write(neo_seqHead)
            fastaFile.write('\n')
            fastaFile.write(seqBody)
            fastaFile.write('\n')
            fastaFile.close()
        
        print(neo_seqHead, len(seqBody))
        
            