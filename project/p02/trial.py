#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Sep 19 17:23:04 2021

This is for p02;

@author: Tek
"""
#This is for q14

n = 0
myFund = 200

if n <= 5:   
    myFund = myFund * 2**n
    n = n + 1
    
print(myFund)