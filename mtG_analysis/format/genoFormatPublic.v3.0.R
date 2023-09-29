genodata = 'BR002.txt'
snpref='rsID.geno.v9.7.final.txt'

#The scrip was prepared on Mar 4-5, 2019;

genoformat <- function(genodata, datatype='txtfile', 
                       snpref='rsID.geno.v9.7.final.txt')
{
  print(Sys.time())
  
  if (datatype=='txtfile') {
    #To retrieve the Geno 2.0 public data:
    Derek<-read.table(genodata, sep=',',skip = 10, header = FALSE)[,c(2,3,4,5)]
   
    #To find duplicate rows:
    Kayta <- which(duplicated(Derek[,1]))
    
    Derek<-Derek[setdiff(1:dim(Derek)[1],Kayta),]
    
    #To set the 1st column as row names:
    rownames(Derek)<-Derek[,1]

    #To extract mtDNA data:
    mtData7 <- subset(Derek, Derek$V3 == 0)

    mtData <-cbind(mtData7[,c(1,2,1)], paste(mtData7[,3], mtData7[,4], sep = ''))
    
    #To update column names:
    colnames(mtData) <- c('rsID', 'Chr', 'Position', 'Genotype')
   
    #To replace '0' with 'MT' to denote mtDNA:
    mtData$Chr <- as.character(mtData$Chr)
    mtData$Chr[mtData$Chr == '0'] <- 'MT'
   
    print('Dimension of mtData:', quote = FALSE)
    print(dim(mtData))
    
    #To retrieve the reference file:
    Ulgi <- read.table(snpref, header = TRUE)
    
    #To set the 1st column as row names of the reference:
    rownames(Ulgi)<-Ulgi[,1]
    
    #To find common row names:
    Ortak<-intersect(rownames(Derek),rownames(Ulgi))
    Ulgi <- Ulgi[Ortak,]
    
    Derek<-Derek[Ortak,]
    
    #To combine the selected columns of Derek and REF:
    Derek7<-cbind(Ulgi[,c(1,2,3)], paste(Derek[,3], Derek[,4], sep = ''))
    
    #To update column names:
    colnames(Derek7) <- c('rsID', 'Chr', 'Position', 'Genotype')
    
    #To extract Y chromosome data:
    yData <- subset(Derek7, Derek7$Chr == 'Y')
    
    print('Dimension of yData:', quote = FALSE)
    print(dim(yData))
    
    #To extract whole genome data:
    wgData <- subset(Derek7, Derek7$Chr != 'Y')
    wgData <- subset(Derek7, Derek7$Chr != '0')
    
    print('Dimension of wgData:', quote = FALSE)
    print(dim(wgData))
  }
  
  #Create a file for mtDNA data:
  write.table(mtData[order(as.numeric(as.character(mtData[,3]))),], 
              file=sprintf('%s.plc.mt.txt', substr(genodata, start = 1, stop = 5)), 
              quote=FALSE,row.names=FALSE,col.names=TRUE, sep = '\t')
  
  #Create a file for Y chromosome data:
  write.table(yData[order(as.numeric(as.character(yData[,3]))),], 
              file=sprintf('%s.plc.y.txt', substr(genodata, start = 1, stop = 5)), 
              quote=FALSE,row.names=FALSE,col.names=TRUE, sep = '\t')
  
  #Create a file for whole genome data:
  write.table(wgData[order(wgData[,2]),], 
              file=sprintf('%s.plc.wg.txt', substr(genodata, start = 1, stop = 5)), 
              quote=FALSE,row.names=FALSE,col.names=TRUE, sep = '\t')
}

