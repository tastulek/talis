#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 24 09:16:47 2019

@author: altaic
"""

import datetime

print(datetime.datetime.now())

old_name = ''
new_name = ''
seqBody = ''


def seqRename(fileList):
    with open('NeoOldName_trial.txt') as idList:
        
        for line in idList:
            sl = line.strip().split('\t')
            old_name = sl[0].strip('.fasta')
            new_name = sl[1].strip('.fasta')
            
            with open('%s.fasta' % old_name) as seqData:
                allData =seqData.read()
                seqID = allData[1:9].rstrip()
                seqBody = allData[9:].strip().rstrip()
     
                neoSeqID = seqID.replace(old_name, new_name)
                neoSeqHeader = '>' + neoSeqID

                    
                with open('%s.fasta' % new_name, 'a') as seqData:
                    
                    seqData.write('%s' % neoSeqHeader)
                    seqData.write('\n%s' % seqBody)
                    
                    seqData.close
    
print(seqRename('NeoOldName_trial.txt'))

            
        