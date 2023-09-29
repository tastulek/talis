genodata = 'BR002.txt'
snpref='rsID.geno.v9.7.final.txt'

#The scrip was prepared on Mar 4-5, 2019;
# The scrip was updated on Nov 19, 2021;

genoformat <- function(genodata, datatype ='txtfile')
{
  print(Sys.time())
  
  if (datatype == 'txtfile') {
    #To retrieve the Geno 2.0 data:
    derek<-read.csv(genodata, sep=',', header = TRUE)
    
    #To update column names:
    colnames(derek) <- c('rsID', 'Chr', 'Position', 'Genotype')
 
    #To extract mtDNA data:
    mt_dna <- subset(derek, derek$CHROMOSOME == 'MT')

    print('Dimension of mtData:', quote = FALSE)
    print(dim(mt_dna))
    

    #To extract Y chromosome data:
    yData <- subset(derek7, derek7$Chr == 'Y')
    
    print('Dimension of yData:', quote = FALSE)
    print(dim(yData))
    
    #To extract whole genome data:
    autosomal <- subset(derek7, derek7$Chr != 'Y')
    autosomal <- subset(derek7, derek7$Chr != 'MT')
    
    print('Dimension of autosomal:', quote = FALSE)
    print(dim(autosomal))
  }
  
  #Create a file for mtDNA data:
  write.table(mtData[order(as.numeric(as.character(mtData[,3]))),], 
              file=sprintf('%s.plc.mt.txt', substr(genodata, start = 1, stop = 5)), 
              quote=FALSE,row.names=FALSE,col.names=TRUE, sep = '\t')
  
  #Create a file for Y chromosome data:
  write.table(yData[order(as.numeric(as.character(yData[,3]))),], 
              file=sprintf('%s.plc.y.txt', substr(genodata, start = 1, stop = 5)), 
              quote=FALSE,row.names=FALSE,col.names=TRUE, sep = '\t')
  
  #Create a file for autosomal data:
  write.table(autosomal[order(autosomal[,2]),], 
              file=sprintf('%s.plc.wg.txt', substr(genodata, start = 1, stop = 5)), 
              quote=FALSE,row.names=FALSE,col.names=TRUE, sep = '\t')
}

