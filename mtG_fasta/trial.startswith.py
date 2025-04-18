#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 18:59:16 2019

@author: altaic
"""

text = "Python programming is easy."

# start parameter: 7
# 'programming is easy.' string is searched
result = text.startswith('programming is', 7)
print(result)

# start: 7, end: 18
# 'programming' string is searched
result = text.startswith('programming is', 7, 18)
print(result)

result = text.startswith('program', 7, 18)
print(result)

seqID = ''

seqID = '>MT:1-16569_|_K6_|_$id'

type(seqID)


print(neoHeader)

import os
os.getcwd()
os.listdir()
os.walk(top)

seqID = '>MT:1-16569_|_K6_|_$id'
neoSeqID = seqID.strip('>MT:1-16569_|_$id')
print(neoSeqID)
neoSeqID2 = neoSeqID.rstrip(

import os
import sys

with open('NeoOldName_trial.txt') as fh:
    for line in fh:
        sl = line.strip().split("\t")
        old_name = sl[0]
        new_name = sl[1]
        os.rename(old_name, new_name)


