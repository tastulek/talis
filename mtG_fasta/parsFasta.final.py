#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 18:35:15 2019

@author: altaic
"""

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 30 09:00:17 2019

@author: altaic
"""

header = ''
seq = ''
header1 = ''
seq1 = ''
seqName = ''
seqSize = 0
seqSizeList = []

def openFasta(dataFile):
    data = open(dataFile).readlines()
    allSeqs = ''.join(data)
    tempFile = allSeqs.split('>')
    tempFile = tempFile[1:]
    
    for indiSeq in tempFile:
        indiSeq = indiSeq.rstrip()
        indiSeq = '>' + indiSeq
        indiSeqHeader = indiSeq.splitlines()[0]
        print()
        print()
        print('The header of the sequence: %s' % indiSeqHeader)
        print()
        indiSeqLines = indiSeq.splitlines()[1:]
        indiSeqBody =''.join(indiSeqLines)
        seqSize = len(indiSeqBody)

        seqData = open('%s.txt' % indiSeqHeader[1:32], 'w')
        seqData.write('%s' % indiSeqBody)
        seqData.close
        print('The length of the sequence [%s]: %d' % (indiSeqHeader[1:32], seqSize))
        seqSizeList.append(seqSize)
        print('----------------')
    print() 
    print('The multiFasta file has %d records in total!' % len(tempFile))
    print()
    print('                 *********                  ')
    print()    
    print('Descending Order of the Sequence Sizes: ', *sorted(seqSizeList, reverse = True), sep = '\n')
    print('------------------ Completed! ------------------')
           
print(openFasta('K6.14.28.fasta') )  
   