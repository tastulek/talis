#For extracting nuclear DNA markers, i.e. the markers from 
#the whole genome proper, excluding mtDNA.
extract.n.dna <- function(ftd.genodata, datatype='txtfile')
{
  if (datatype == 'txtfile') {
    
    #To retrieve the formatted Geno 2.0 data file:
    derek <- read.table(ftd.genodata, skip = 0, sep = '\t', 
                        header = TRUE) 
    
    #Extract the mtDNA portion of the Geno 2.0 data:
    mtDNA <- subset(derek, derek$Chr == 'MT') 
    
    #To set row names for X and mtDNA:
    rownames(derek) = derek[,1]
    rownames(mtDNA) = mtDNA[,1]
    
    #To remove mtDNA SNPs from the complete dataset X:
    nuclearDNA <- setdiff(rownames(derek), rownames(mtDNA))
    nuclearDNA <- derek[nuclearDNA, ]

  }
  
  
  #To create a nuclear DNA (i.e. whole genome) data file 
  #with rows ordered by Chr:
  write.table(nuclearDNA[order(nuclearDNA[,2]),], 
              file=sprintf('%s.n.wg.txt', substr(ftd.genodata, 
                                                     start = 1, stop = 9)),
              quote=F,sep = '\t', row.names=FALSE,col.names=TRUE)
}
