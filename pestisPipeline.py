#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Apr 23 11:13:58 2021

@author: Tek [Ayken Askapuli]

Micro657 Final Project 
Spring 2021

This script [pestisPipeline.py] is a pipeline for automating bacterial genome assembly;
"""

import sys
import subprocess

SRA =''
global sraList





#For reading the list of SRA IDs to be processed;

with open(sys.argv[1], 'r') as sraList:
        sraList = sraList.readlines()

        #For creating folders for data storage;

        subprocess.run(['mkdir', 'pestisSRA', 'pestisSeqFiltered', 'pestisAssembly', 'assemblyStats'])
        
        for SRA in sraList:
            SRA = SRA.strip()
            
            print()
            print('Started processing SRA: %s' % SRA)
            
            #Download SRA data using prefetch command of the SRA toolkit;

            subprocess.run(['time','prefetch',SRA ])
            
            #Move the downloaded SRA to the SRA data folder: pestisSRA;

            subprocess.run(['mv', SRA, 'pestisSRA/'])
            
            #Convert *.sra file into *.fastaq file(s);

            subprocess.run(['fastq-dump','--split-spot', '--split-files', ('pestisSRA/%s/' % SRA)+('%s.sra' % SRA), 
                            '--outdir', ('pestisSRA/%s/' % SRA)])
            
            #Preprocess *.fastq files using fastp program;

            subprocess.run(['fastp','--in1', ('pestisSRA/%s/' % SRA)+('%s_1.fastq' % SRA), '--in2', ('pestisSRA/%s/' % SRA)+('%s_2.fastq' % SRA),
                            '--out1', ('%s_1.fastq' % SRA),'--out2', ('%s_2.fastq' % SRA)])
            
            #Make a new sub-directory for storing the refined fastq files;

            subprocess.run(['mkdir', ('pestisSeqFiltered/%s' % SRA)])
            
            #Move the preprocessed fastq files into the folder: pestisSeqFiltered;

            subprocess.run(['mv', 'fastp.html', 'fastp.json', ('%s_1.fastq' % SRA), ('%s_2.fastq' % SRA), ('pestisSeqFiltered/%s/' % SRA)])
            
            #Assemble the bacterial genome using SPAdes program and store the output in the folder: pestisAssembly;

            subprocess.run(['spades.py', '--pe1-1', ('pestisSeqFiltered/%s/' % SRA)+('%s_1.fastq' % SRA),
                            '--pe1-2',('pestisSeqFiltered/%s/' % SRA)+('%s_2.fastq' % SRA),'--only-assembler', '-o', ('pestisAssembly/%s/' % SRA)])
                
            #Copy and rename contig.fasta as SRA_assembly.fasta and move it to the new folder: assemblyStats;

            subprocess.run(['cp',('pestisAssembly/%s/contigs.fasta' % SRA),('%s_assembly.fasta' % SRA)])
            
            #Run the python script for generating assembly quality statistics;

            subprocess.run(['python3', 'assemblyStats.py',('%s_assembly.fasta' % SRA)])
            
            subprocess.run(['mv', ('%s_assembly.fasta' % SRA),('%s_assembly.xlsx' % SRA), 'assemblyStats/'])
           
        print()
        print('Completed processing SRA: %s' % SRA)
                    
            
        
    
    