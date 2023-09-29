#For extracting nuclear DNA markers, i.e. the markers from 
#the whole genome proper, excluding mtDNA.
extract.y <- function(ftd.genodata, datatype='txtfile')
{
  if (datatype == 'txtfile') {
    
    #To retrieve the formatted Geno 2.0 data file:
    derek <- read.table(ftd.genodata, skip = 0, sep = '\t', 
                        header = TRUE) 
    
    #Extract the mtDNA portion of the Geno 2.0 data:
    yChr <- subset(derek, derek$Chr == 'Y') 
  
  }
  
  
  #To create a nuclear DNA (i.e. whole genome) data file 
  #with rows ordered by Chr:
  write.table(yChr[order(yChr[,3]),], 
              file=sprintf('%s.y.txt', substr(ftd.genodata, 
                                                     start = 1, stop = 9)),
              quote=F,sep = '\t', row.names=FALSE,col.names=TRUE)
}
