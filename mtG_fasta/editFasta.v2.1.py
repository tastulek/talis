#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 18:16:59 2019
This python script is for editing fasta sequence identifier.

@author: altaic
"""
import datetime

dataFile = ''
header = ''
seq = ''
indiSeq = ''
indiSeqHeader = ''
seqSize = 0
tempFile = ''
seqSizeList = []
#Start from the first cell;
row = 0
col = 0


def editFasta(dataFile):
    data = open(dataFile).readlines()
    allSeqs = ''.join(data)
    tempFile = allSeqs.split('>')
    tempFile = tempFile[1:]
    
    for indiSeq in tempFile:
        indiSeq = indiSeq.rstrip()
        indiSeq = '>' + indiSeq
        indiSeqHeader = indiSeq.splitlines()[0]
        indiSeqHeader = indiSeqHeader.strip('>')
        print()
        print()
        print('The Original Seq ID: %s' % indiSeqHeader)
        
        print()
        
        indiSeqLines = indiSeq.splitlines()[1:]
        indiSeqBody = ''.join(indiSeqLines)
        seqSize = len(indiSeqBody)
        
        tempID = indiSeqHeader.replace('MT:1-16569_|_K', 'KZ').strip()
        shortID = tempID.replace('_|_$id', '.mtG').rstrip()
        
       
        neoHeader = '>' + shortID
        
        seqData = open('%s.fasta' % shortID, 'w')
        seqData.write('%s' % neoHeader)
        seqData.write('\n%s' % indiSeqBody)
        
        seqData.close
        
       
    
        print('The length of the Seq with the Neo ID [%s]: %d' % (shortID, seqSize))
        seqSizeList.append(seqSize)
        
        print('----------------')
    
    print() 
    print('The multiFasta file has %d records in total!' % len(tempFile))
    print()
    print('                 *********                  ')
    print()    
    print('Descending Order of the Sequence Sizes: ', *sorted(seqSizeList, reverse = True), sep = '\n')
    print('------------------ Completed! ------------------')
    print(datetime.datetime.now())
          
print(editFasta('Kazak.jetisuu.true.mtG.fasta') )  
   
            
            
            
            
            
            
            
            
        
        
        
        