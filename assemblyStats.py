#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 27 11:15:25 2021

@author: Tek [Ayken Askapuli]

Micro657 Final Project 
Spring 2021

This script [assemblyStats.py] is for parsing bacterial genome assembly and performing quality assessment;

"""
import sys
import datetime
import xlsxwriter
import numpy


contigFile = ''
contigData = []
allContigs = ''
node = ''
indiContig = ''
indiContigHeader = ''
contigSize = 0
countN = 0
listTotalCountN = []
totalCountN = ''
ListPercentGC = []
contigSizeList = []
sortedContigSizeList = []
cumSum = 0
cumSumList = []
sortedCumSumList = []
HalfValue = 0
largeContig =[]
sortedLargeContig = []
cumSumSorted = 0
cumSumSortedList = []
iList = []
iListSorted = []
N50 = ''


#Start from the 3rd row of Excel sheet 3;
row = 2


contigFile = sys.argv[1]

def assemblyStats(contigFile):
    
    #To create an Excel file for writing assembly statistics;

    assemblyStats = xlsxwriter.Workbook('%s.xlsx' % contigFile.strip('.fasta'))

    #Adding three sheets to the Excel file;

    assemblyStatsSheet01 = assemblyStats.add_worksheet('assemblyStats')
    assemblyStatsSheet02 = assemblyStats.add_worksheet('contigOverview')
    assemblyStatsSheet03 = assemblyStats.add_worksheet('contigStats')
    
    #Setting text format configurations for the Excel file:

    bold = assemblyStats.add_format({'bold' : True, 'font_size': '17' })
    largeText = assemblyStats.add_format({'bold' : True, 'font_size': '14' })
    formatGC = assemblyStats.add_format({'num_format': '#,#0.00'})
    formatGC.set_font_size('14')
    formatGC.set_align('center')
    formatContigSize = assemblyStats.add_format({'num_format': '#,##0'})
    formatContigSize.set_font_size('14')
    alignCenter = assemblyStats.add_format()
    alignCenter.set_align('center')
    alignCenter.set_font_size('14')
    alignLeft = assemblyStats.add_format()
    alignLeft.set_align('left')
    alignLeft.set_font_size('14')
    
    #Adding tables and writing captions and cell values:
    #This block is for Sheet 1;

    assemblyStatsSheet01.add_table('B2:C8', {'autofilter': 0, 'style': 'Table Style Light 2'})
    captionTable_1 = 'Table 1. Overall Assembly Statistics for %s' % contigFile.strip('.fasta')
    assemblyStatsSheet01.set_column('B:B', 21 )
    assemblyStatsSheet01.write('B1', captionTable_1, largeText)
    assemblyStatsSheet01.write('B2', 'Assembly Stats', bold)
    assemblyStatsSheet01.set_column('C:C', 10, formatContigSize)
    assemblyStatsSheet01.write('C2', 'Value', bold)
    
    #This block is for Sheet 2;

    assemblyStatsSheet02.add_table('B2:C10', {'autofilter': 0, 'style': 'Table Style Light 2'})
    captionTable_2 = 'Table 2. Contig Summary Statistics for %s' % contigFile.strip('.fasta')
    assemblyStatsSheet02.set_column('B:B', 43 )
    assemblyStatsSheet02.write('B1', captionTable_2, largeText)
    assemblyStatsSheet02.write('B2', 'Contig Parameter', bold)
    assemblyStatsSheet02.set_column('C:C', 10, alignLeft)
    assemblyStatsSheet02.write('C2', 'Value', bold)

    #This block is for Sheet 3;
    
    captionTable_3 = 'Table 3. Statistics for the Individual Contigs of %s' % contigFile.strip('.fasta')
    assemblyStatsSheet03.write('A1', captionTable_3, largeText)
    assemblyStatsSheet03.set_column('A:A', 12, alignLeft)
    assemblyStatsSheet03.write('A2', 'Node', bold)
    assemblyStatsSheet03.set_column('B:B', 14, alignLeft)
    assemblyStatsSheet03.write('B2', 'Contig Size', bold)
    assemblyStatsSheet03.set_column('C:C', 3, alignCenter)
    assemblyStatsSheet03.write('C2', 'N', bold)
    assemblyStatsSheet03.set_column('D:D', 14, alignCenter)
    assemblyStatsSheet03.write('D2', 'GC Content', bold)
    assemblyStatsSheet03.set_column('E:E', 40, alignLeft)
    assemblyStatsSheet03.write('E2', 'Contig Header', bold)
    assemblyStatsSheet03.set_column('F:F', 23, alignLeft)
    assemblyStatsSheet03.write('F2', 'Project Info', bold)
    
    
    #Writing from the 3rd row of Excel Sheet 3;

    row = 2
    
    #To open the assembly fasta file and retrieve contig sequences;

    with open(contigFile, 'r') as contigData:
            
        #Collecting all lines in a list, where each line is an element of the list,
        #but the original order of the contigs unchanged;
        
        contigData = contigData.readlines()
       
        
        #Joining all lines as a string, where individual characters are kept in lines that are
        #ordered as given in the previous list (i.e. contigData);
        
        allContigs = ''.join(contigData)


        #Split the string at the character '>', which enables us to separate
        #individual contigs from one another, and store them in a list named [splitContigs];

        splitContigs = allContigs.split('>')
      
        
        #The first element of the list, i.e. splitContigs[0], has nothing, i.e [''],
        #therefore, we exclude it from further steps;

        splitContigs = splitContigs[1:]
        
        #Parsing individual contigs;

        for indiContig in splitContigs:

            #Removing trailling character, such as space or '\n', at the end of contig DNA sequence;

            indiContig = indiContig.rstrip()
   
            #Get the defline, which is the first element of the list;

            indiContigLines = indiContig.splitlines()
            indiContigHeader = indiContigLines[0]
        
            indiContigBody = indiContigLines[1:]
            indiContigBody = ''.join(indiContigBody)

            #To obtain Node ID;
            
            nodeStart = indiContigHeader.find('NODE_\d+') + 1
            nodeEnd = indiContigHeader.find('length')
    
            node = indiContigHeader[nodeStart: nodeEnd].strip()
            node = node.strip('_')
            
            #To get the length of the individual contig;

            contigSize = len(indiContigBody)
     
            #To calculate GC content of each contig:
                
            countG = indiContigBody.count('G') 
            countC = indiContigBody.count('C')

            percentGC = ((countG + countC) / contigSize) * 100
            percentGC = numpy.round(percentGC, decimals = 2)
            
            #To obtain the average GC content in the whole assembly;

            ListPercentGC.append(percentGC)
            
            totalPercentGC = sum(ListPercentGC)/len(ListPercentGC)
            totalPercentGC = numpy.round(totalPercentGC, decimals = 2)
            
            #To count the number of 'N', if there is any;

            countN = indiContigBody.count('N')

            #To count the total number of 'Ns' in the assembly;

            listTotalCountN.append(countN)
            totalCountN = sum(listTotalCountN)
            
   
            #This block is for writing individual contig stats in the Excel file;

            assemblyStatsSheet03.write(row, 0, node)
            assemblyStatsSheet03.write(row, 1, contigSize, formatContigSize)
            assemblyStatsSheet03.write(row, 2, countN)
            assemblyStatsSheet03.write(row, 3, percentGC, formatGC)
            assemblyStatsSheet03.write(row, 4, indiContigHeader)
            assemblyStatsSheet03.write(row, 5, 'Micro657 Final Project')
            
            #For creating a list for contig size:
            
            contigSizeList.append(contigSize)
            
            
            row += 1
            
        #For calculating toltal length of contigs:
        
        cumSum = 0
    
        for i in contigSizeList:
        
            cumSum = cumSum + i
            
            cumSumList.append(cumSum)            
     
        
        print('                 *********                  ')
        print()
        print('The Assembly Name: %s' % contigFile)
        print()
        print('The Assembly has %d Contigs in Total!' % len(contigSizeList))
        print('The Total Length of the Assembly: %s bp' % f'{cumSum:,}')



        #The following block is for calculating assembly parameters;
            
        Ns_per1K = (totalCountN * 1000) / cumSum 
            
            
        #Total number of contigs;

        totalContig = len(contigSizeList)
        
        #Contigs shorter than 1000 bp;

        contigLess1K = 0
        for i in contigSizeList:
        
            if i < 1000:
                contigLess1K = contigLess1K + 1
                
        #Contigs between 1000 and 5000 bp;

        contig1K_5K = 0
        for i in contigSizeList:
        
            if i >= 1000 and i <= 5000:
                contig1K_5K = contig1K_5K + 1
                
        #Contigs longer than 5000 bp;

        contigLonger5K = 0
        for i in contigSizeList:
        
            if i > 5000:
                contigLonger5K = contigLonger5K + 1
                
        #Contigs longer than 10,000 bp;

        contigLonger10K = 0
        for i in contigSizeList:
        
            if i > 10000:
                contigLonger10K = contigLonger10K + 1
                
        #Contigs longer than 25,000 bp;

        contigLonger25K = 0
        for i in contigSizeList:
        
            if i > 25000:
                contigLonger25K = contigLonger25K + 1
                
        #Contigs longer than 50,000 bp;

        contigLonger50K = 0
        for i in contigSizeList:
        
            if i > 50000:
                contigLonger50K = contigLonger50K + 1
                
                
        sortedContigSizeList = sorted(contigSizeList, reverse = True)
        
        lastEl = len(sortedContigSizeList) - 1

        smallestContig = sortedContigSizeList[lastEl] 
        smallestContig = int(smallestContig)
        
        largestContig = sortedContigSizeList[0]
        largestContig = int(largestContig)

        #The following block is for N50 calculation:
            
        global cumSumSorted
        for i in sortedContigSizeList:
        
            cumSumSorted = cumSumSorted + i
            
            cumSumSortedList.append(cumSumSorted)
        
        HalfValue = cumSumSorted * (1/2)

        for i in range(0,len(sortedContigSizeList)):
            
            if cumSumList[i] >= HalfValue:
                
                iList.append(i)
                
            
            iListSorted = sorted(iList, reverse = False)
            
        firstEl = iListSorted[0]
        
        N50 = sortedContigSizeList[firstEl]
        N50 = int(N50)
        
        print()
        print()
        print('The N50 Value of the Assembly: [ %s ]' % f'{N50:,}')


        #The following block is for recording the assembly parameters in the Excel file;
          
        assemblyStatsSheet01.write('B3', 'Smallest Contig (bp)', largeText)
        assemblyStatsSheet01.write('C3', smallestContig, largeText)
        assemblyStatsSheet01.write('B4', 'Largest Contig (bp)', largeText)
        assemblyStatsSheet01.write('C4', f'{largestContig:,}', largeText)
        assemblyStatsSheet01.write('B5', 'N50', largeText)
        assemblyStatsSheet01.write('C5', f'{N50:,}', largeText)
        assemblyStatsSheet01.write('B6', 'GC Content (%)', largeText)
        assemblyStatsSheet01.write('C6', totalPercentGC, largeText)
        assemblyStatsSheet01.write('B7', 'Ns in Total', largeText)
        assemblyStatsSheet01.write('C7', countN, largeText)
        assemblyStatsSheet01.write('B8', 'Ns per 1K bp', largeText)
        assemblyStatsSheet01.write('C8', Ns_per1K, largeText)

        assemblyStatsSheet02.write('B3', 'Contigs in Total', largeText)
        assemblyStatsSheet02.write('C3', totalContig, largeText)
        assemblyStatsSheet02.write('B4', 'Number of Petite Contigs (< 1K bp)', largeText)
        assemblyStatsSheet02.write('C4', contigLess1K, largeText)
        assemblyStatsSheet02.write('B5', 'Number of Small Contigs (1K – 5K bp)', largeText)
        assemblyStatsSheet02.write('C5', contig1K_5K, largeText)
        assemblyStatsSheet02.write('B6', 'Number of Contigs Longer than 5K bp', largeText)
        assemblyStatsSheet02.write('C6', contigLonger5K, largeText)
        assemblyStatsSheet02.write('B7', 'Number of Contigs Longer than 10K bp', largeText)
        assemblyStatsSheet02.write('C7', contigLonger10K, largeText)
        assemblyStatsSheet02.write('B8', 'Number of Contigs Longer than 25K bp', largeText)
        assemblyStatsSheet02.write('C8', contigLonger25K, largeText)
        assemblyStatsSheet02.write('B9', 'Number of Contigs Longer than 50K bp', largeText)
        assemblyStatsSheet02.write('C9', contigLonger50K, largeText)
        assemblyStatsSheet02.write('B10','Combined Size of All Contigs', largeText)
        assemblyStatsSheet02.write('C10', f'{cumSum:,}', largeText)
            
        assemblyStats.close()
        print() 
        
        print()
        print('                 *********                  ')
        print()    
        print('The Size of 9 Largest Contigs: ', *sorted(contigSizeList[0:9], reverse = True), sep = '\n')
        print('------------------ Completed! ------------------')
        print(datetime.datetime.now())

print(assemblyStats(contigFile))       
                
                
                
                    
                    
                    
                    
                    
                
                
                
                
