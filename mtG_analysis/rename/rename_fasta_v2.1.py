#!/usr/bin/env python
# coding: utf-8

# In[ ]:
import sys

def rename_fasta_v2(file):
    file = sys.argv[1]
    print(file)
    #os.makedirs(os.path.dirname(file), exist_ok=True)
    with open(file, 'r', encoding = 'utf-8') as datafile:
        seqStr = datafile.read()
        seqList = seqStr.split('\n')
        seqHead = seqList[0]
        seqBody = ''.join(seqList[1:])
        datafile.close()
        
        start = seqHead.find('|gb|') + 4
        end = seqHead.find('Homo') - 2

        print(start, end)
        
        tempID = seqHead[start: end].strip()
        print(tempID)
        
        neo_seqHead = '>' + tempID.replace('.1', '').rstrip()
        print(neo_seqHead)
        
        
        with open(file, 'w', encoding = 'utf-8') as fastaFile:
            fastaFile.write(neo_seqHead)
            fastaFile.write('\n')
            fastaFile.write(seqBody)
            fastaFile.write('\n')
            fastaFile.close()
        print(neo_seqHead, len(seqBody))
