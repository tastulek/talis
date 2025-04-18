#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 18:16:59 2019
This python script is for editing fasta sequence identifier.

@author: altaic
"""
import datetime
import xlsxwriter

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


def editFasta(dataFile):
    
    seqStats = xlsxwriter.Workbook('%s.v3.1.xlsx' % dataFile.strip('.fasta'))
    seqStatsSheet =seqStats.add_worksheet('seqStats')
    row = 0
    
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
        
        start = indiSeqHeader.find('isolate') + 9
        end = indiSeqHeader.find('sq') + 6
        
        tempID = indiSeqHeader[start: end].strip()
        
        shortID = tempID.replace('sq', '').rstrip()
        
      
        neoHeader = '>' + shortID
        
        seqData = open('%s.fasta' % shortID, 'w')
        seqData.write('%s' % neoHeader)
        seqData.write('\n%s' % indiSeqBody)
        
        #This block is for writing seq stats in an excel file;
        #The data need to be collected:
       #neededData = ([shortID, seqSize, indiSeqHeader], )
        
    
        seqStatsSheet.write(row, 0, shortID)
        seqStatsSheet.write(row, 1, seqSize)
        seqStatsSheet.write(row, 2, indiSeqHeader)
        
        
    
        print('The length of the Seq with the Neo ID [%s]: %d' % (shortID, seqSize))
        seqSizeList.append(seqSize)
        
        print('----------------')
        
        row += 1
    
    
    seqStats.close()
    print() 
    print('The multiFasta file has %d records in total!' % len(tempFile))
    print()
    print('                 *********                  ')
    print()    
    print('Descending Order of the Sequence Sizes: ', *sorted(seqSizeList, reverse = True), sep = '\n')
    print('------------------ Completed! ------------------')
    print(datetime.datetime.now())
          
print(editFasta('Japanese_mtG_Tanaka04.fasta') )  
   
            
            
            
            
            
            
            
            
        
        
        
        