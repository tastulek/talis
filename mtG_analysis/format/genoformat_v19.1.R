genoformat <- function(genodata, datatype='txtfile', 
                       snpref='rsID.geno.v9.7.final.txt')
{
  if (datatype=='txtfile') {
    X<-read.table(genodata,sep='\t',skip=10, header = TRUE)[,c(2,3,4)]
    DUP <- which(duplicated(X[,1]))
    X<-X[setdiff(1:dim(X)[1],DUP),]
    rownames(X)<-X[,1]
    REF <- read.table(snpref)
    rownames(REF)<-REF[,1]
    COMMON<-intersect(rownames(X),rownames(REF))
    REF <- REF[COMMON,]
    X<-X[COMMON,]
    
    #To combine the selected columns of X and REF:
    X7<-cbind(REF[,c(1,2,3)], paste(X[,2], X[,3], sep = ''))
    
    #To update column names:
    colnames(X7) <- c('rsID', 'Chr', 'Position', 'Genotype')
  }
  notxtgeno <- gsub('.txt', '', genodata)
  
  write.table(X7[order(X7[,2]),],file=sprintf('%s.neo.ftd.txt', 
                                              substr(notxtgeno, 
                                                     start = 1, stop = 5)), 
              quote=FALSE,row.names=FALSE,col.names=TRUE, sep = '\t')
}

